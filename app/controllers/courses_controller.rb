# encoding: utf-8

class CoursesController < ApplicationController
  load_and_authorize_resource :except => [:webinars, :all_courses]
  before_action :authenticate_user!, :except => [:index, :webinars, :all_courses, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :parse_course_params, only: [:create, :update]
  skip_authorization_check :only => [:webinars, :all_courses]
  after_action :save_and_update_teachers, only: [:create, :update]
  after_action :increase_visit_count, only: [:show]
  
  # GET /courses
  def index
    @searching = true
    @courses = Course.where(:webinar => false).paginate(:per_page => 24, :page => params[:page].blank? ? 1 : params[:page])
    params[:webinar] = 0
  end

  # GET /webinars
  def webinars
    @searching = true
    @courses = Course.webinars.paginate(:per_page => 24, :page => 1)
    params[:webinar] = 1
    render "index"
  end

  # GET /all_courses
  def all_courses
    @searching = true
    @courses = Course.all.paginate(:per_page => 24, :page => 1)
    render "index"
  end

  # GET /courses/1
  def show
    @related_courses = RecommenderSystem.getRecommendCourses(@course,4)
  end


  # GET /courses/new
  def new
    @course = Course.new
    @course.webinar = (params[:webinar] == "1")
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.selfpaced =  course_params[:selfpaced] == "selfpaced"
    if @course.selfpaced
      @course.start_date = nil
      @course.end_date = nil
    end
    if @course.save
      redirect_to @course, notice: I18n.t("course.successfully_created")
    else
      flash.now[:alert] = @course.errors.full_messages.join(". ")
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    params.require(:course)[:webinar] = @course.webinar # do not allow to change from course to webinar or viceversa
    if @course.update(course_params)
      @course.selfpaced = course_params[:selfpaced] == "selfpaced"
      if @course.selfpaced
        @course.start_date = nil
        @course.end_date = nil
      end

      if params.require(:course)[:thumb_delete] == "1"
        @course.thumb = nil
      end
      if params.require(:course)[:thumb_min_delete] == "1"
        @course.thumb_min = nil
      end
      if params.require(:course)[:powered_by_logo_delete] == "1"
         @course.powered_by_logo = nil
      end
      @course.save!
      redirect_to @course, notice: I18n.t("course.successfully_updated")
    else
      flash.now[:alert] = @course.errors.full_messages.join(". ")
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice:  I18n.t("course.successfully_destroyed")
  end

  # POST /courses/1/enroll
  def enroll
    if user_signed_in?
      if current_user.courses.include?(@course)
        redirect_to @course, notice: I18n.t("course.errors.already_enrolled")
      elsif !@course.spots.blank? and (@course.enrollments.length >= @course.spots)
          redirect_to @course, notice: I18n.t("course.errors.overcrowded")
      elsif !@course.is_enrollment_period?
          redirect_to @course, notice: I18n.t("course.errors.not_active")
      else  
        #Enroll
        if @course.enroll_user(current_user)
          redirect_to @course, notice: I18n.t("course.enrollment_success")
        else
          redirect_to @course, notice: I18n.t("course.errors.enrollment_generic")
        end
      end
    else
      redirect_to @course, notice: I18n.t("authorization.errors.generic")
    end
  end

  # POST /courses/1/unenroll
  def unenroll
    if user_signed_in?
      if current_user.courses.include?(@course)
        #Unenroll
        if @course.unenroll_user(current_user)
          redirect_to @course, notice: I18n.t("course.unenrollment_success")
        else
          redirect_to @course, notice: I18n.t("course.errors.unenrollment_generic")
        end
      else
        redirect_to @course, notice: I18n.t("course.errors.no_enrolled")
      end
    else
      redirect_to @course, notice: I18n.t("authorization.errors.generic")
    end
  end

  # POST /courses/1/rate
  def rate
    return (redirect_to @course, notice: I18n.t("course.errors.no_rating")) if params[:rating].blank?

    if user_signed_in? and current_user.courses.include?(@course)
      #Rate
      if @course.add_rating(current_user,params[:rating])
        @course.update_rating
        redirect_to @course, notice: "Rating success"
      else
        redirect_to @course, notice: "Rating error"
      end
    else
      redirect_to @course, notice: I18n.t("authorization.errors.generic")
    end
  end

  # GET /menrollment
  def menrollment
    unless user_signed_in? and current_user.isAdmin?
      redirect_to "/", notice: I18n.t("authorization.errors.generic")
    end
  end

  # POST /menrollment
  def menrollment_create
    unless user_signed_in? and current_user.isAdmin?
      redirect_to "/menrollment", notice: I18n.t("authorization.errors.generic")
      return
    end

    csv_text = params[:csv].read rescue nil
    courses = params[:courses].split(",") rescue nil
    if csv_text.nil?
      redirect_to "/menrollment", notice: t("course.csv_invalid") 
      return
    elsif courses.nil?
      redirect_to "/menrollment", notice: t("course.csv_courses_invalid")
    else
      require 'csv'
      csv = CSV.parse(csv_text, {:headers => true, encoding: 'utf-8'})
      headers = csv.headers.map{|h| I18n.transliterate(h).downcase}

      emailIndex = headers.index("email") || headers.index("direccion de correo")
      nameIndex = headers.index("name") || headers.index("nombre")
      if emailIndex.nil? or nameIndex.nil?
        redirect_to "/menrollment", notice: t("course.csv_invalid") 
        return
      end
      surnameIndex = headers.index("surname") || headers.index("apellido(s)")
      passwordIndex = headers.index("password") || headers.index("contrasena")
      csv.each do |row|
        email = row[emailIndex]
        user = User.find_by_email(email)
        if user.blank?
          #Create user
          user = User.new
          user.roles.push(Role.user)
          user.email = email
          user.name = row[nameIndex]
          unless surnameIndex.nil?
            user.name = user.name + " " + row[surnameIndex]
            user.surname = row[surnameIndex]
          end
          user.username = user.name
          user.password = (!passwordIndex.nil? and !row[passwordIndex].blank?) ? row[passwordIndex] : "odc-cambiame" 
          user.ui_language = I18n.default_locale
          user.confirmed_at = DateTime.now
          user.skip_confirmation!
          user.save
        end
        #Enroll user in courses
        if user.persisted?
          courses = Course.where(id: courses)
          courses.each do |course|
            course.enroll_user(user)
          end
        end
      end

      redirect_to "/", notice: t("course.massive_enrollment_success")
    end
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course)[:categories] ||= []

    params.require(:course).permit(:name,:description,:start_date,:end_date,:start_enrollment_date,:end_enrollment_date,:format,:alt_link,:retransmission,:video,:type,:dedication,:powered_by,:powered_by_logo,:powered_by_link,:teaching_guide,:lang,:url,:lessons,:thumb,:thumb_min,:webinar, :target_audience, :selfpaced, :spots, categories: [], contents: [:title, topics: []], teachers_order: [])
  end

  def teachers_params
    params.require(:course).permit(teachers: [:id, :name, :position, :facebook, :linkedin, :twitter, :instagram, :bio, :order, :avatar, :avatar_delete])
  end

  def parse_course_params
    return if params[:course].blank?
    params[:course][:webinar] = (params[:course][:webinar] == "1")
    offset = (cookies()[:utc_offset] || "0").to_i 
    if params[:course][:date] 
      split_date = params[:course][:date].split(" - ")
      params[:course][:start_date] = helpers.parse_date(split_date[0], @course.webinar, offset)
      params[:course][:end_date] = helpers.parse_date(split_date[1], @course.webinar, offset)
    end
    if params[:course][:enrollment_date] 
      split_date = params[:course][:enrollment_date].split(" - ")
      params[:course][:start_enrollment_date] = helpers.parse_date(split_date[0], @course.webinar, offset)
      params[:course][:end_enrollment_date] = helpers.parse_date(split_date[1], @course.webinar, offset)
    end
  end
  def save_and_update_teachers
    @course.teachers = []
    return if teachers_params["teachers"].blank?
    teachers_order = {}
    teachers_params["teachers"].each do |teacherParams|
      teacher = CourseTeacher.find_by_id(teacherParams["id"]) || CourseTeacher.where(:name => teacherParams[:name]).first || CourseTeacher.new
      id = teacher.id || teacherParams["id"] 
      teacher.assign_attributes(teacherParams.reject{|k,v| k=="order" or k == "avatar_delete"})
      teacher.id = id
      if teacherParams["avatar_delete"] == "1"
        teacher.avatar = nil
      end

      if teacher.save
        @course.teachers.push(teacher)
        @course.teachers = @course.teachers.uniq { |f| [ f.id ] }
        teachers_order[teacher.id.to_s] = teacherParams[:order] unless teacherParams[:order].blank?
      end
    end

    unless teachers_order.blank?
      @course.teachers_order = teachers_order
      @course.save
    end
  end

  def increase_visit_count
    return if Utils.isUserAgentBot?(request.env["HTTP_USER_AGENT"])
    @course.update_column(:visit_count, @course.visit_count+1)
  end


end