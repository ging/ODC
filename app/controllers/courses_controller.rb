# encoding: utf-8

class CoursesController < ApplicationController
  load_and_authorize_resource :except => [:webinars, :all_courses]
  before_action :authenticate_user!, :except => [:index, :webinars, :all_courses, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :enrollments]
  before_action :parse_course_params, only: [:create, :update]
  skip_authorization_check :only => [:webinars, :all_courses]
  after_action :save_and_update_teachers, only: [:create, :update]
  after_action :increase_visit_count, only: [:show]

  # GET /courses
  def index
    @courses = SearchSystem.search({:browse => true, :locale => I18n.locale.to_s, :webinar => false, :per_page => 24, :page => params[:page]})

    @searching = true
    params[:webinar] = "false"
  end

  # GET /webinars
  def webinars
    @courses = SearchSystem.search({:browse => true, :locale => I18n.locale.to_s, :webinar => true, :per_page => 24, :page => params[:page]})
    @searching = true
    params[:webinar] = "true"

    render "index"
  end

  # GET /all_courses
  def all_courses
    respond_to do |format|
      format.html {
        @courses = SearchSystem.search({:browse => true, :locale => I18n.locale.to_s, :per_page => 24, :page => params[:page]})
        @searching = true
        render "index"
      }
      format.json {
        nCourses = Course.count
        @courses = SearchSystem.search({:browse => true, :n => nCourses, :per_page => nCourses})
        render json: @courses.map{|c| c.public_json}
      }
    end
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

  # GET /courses/1/enrollments
  def enrollments
    @enrollments = @course.users
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=" + t('course.enrollments') + "_" + @course.id.to_s + ".xlsx"
      }
    end
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
          redirect_to @course, notice: @course[:webinar] ? I18n.t("webinar.enrollment_success"): I18n.t("course.enrollment_success")
          begin
            @url = request.base_url
            @offset_orig = cookies()[:utc_offset].blank? ? (Time.now.in_time_zone('Europe/Madrid').utc_offset/-60) : (cookies()[:utc_offset]).to_i
            @offset = @offset_orig
            @spain_time = cookies()[:utc_offset].blank? ? Time.now.in_time_zone('Europe/Madrid').formatted_offset : nil
            @timezone = cookies()[:utc_timezone] || 'Europe/Madrid'
            EnrollmentConfirmationMailer.enrollment_confirmation(current_user.email, current_user.name, @course, @url, @offset_orig, @offset, @spain_time, @timezone).deliver_now
          rescue
            flash[:error] = "E-mail to #{current_user.email} could not be sent"
          end
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
          redirect_to @course, notice: @course[:webinar] ? I18n.t("webinar.unenrollment_success"): I18n.t("course.unenrollment_success")
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
      #csv_text = csv_text.force_encoding("UTF-8")
      #csv_text.gsub!("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
      csv = CSV.parse(csv_text, {:headers => true, encoding: "iso-8859-1"})
      headers = csv.headers.map{|h| I18n.transliterate(h).downcase}

      emailIndex = headers.index("email") || headers.index("direccion de correo")
      nameIndex = headers.index("firstname") || headers.index("name") || headers.index("nombre")
      if emailIndex.nil? or nameIndex.nil?
        redirect_to "/menrollment", notice: t("course.csv_invalid")
        return
      end
      surnameIndex  = headers.index("lastname") || headers.index("surname") || headers.index("apellido(s)")
      passwordIndex = headers.index("password") || headers.index("contrasena")
      csv.each do |row|
        email = row[emailIndex].downcase
        user = User.find_by_email(email)
        if user.blank?
          #Create user
          user = User.new
          user.roles.push(Role.user)
          user.email = email
          user.name = row[nameIndex]
          unless surnameIndex.nil?
            user.surname = row[surnameIndex]
          end
          user.password = (!passwordIndex.nil? and !row[passwordIndex].blank?) ? row[passwordIndex] : "odc-cambiame"
          user.ui_language = I18n.default_locale
          user.confirmed_at = DateTime.now
          #user.skip_confirmation!
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


  # GET /metrics
  def metrics
    unless user_signed_in? and current_user.isAdmin?
      redirect_to "/", notice: I18n.t("authorization.errors.generic")
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params.require(:course)[:categories] ||= []

    params.require(:course).permit(:name,:description,:start_date,:end_date,:start_enrollment_date,:end_enrollment_date,:format,:alt_link,:retransmission,:video,:type,:dedication,:powered_by,:powered_by_logo,:powered_by_link,:teaching_guide,:lang,:card_lang,:url,:lessons,:thumb,:thumb_min,:webinar, :target_audience, :selfpaced, :spots, categories: [], contents: [:title, topics: []], teachers_order: [])
  end

  def teachers_params
    params.require(:course).permit(teachers: [:id, :name, :position_es, :position_en, :position_ca, :facebook, :linkedin, :twitter, :instagram, :bio_es, :bio_en, :bio_ca, :order, :avatar, :avatar_delete])
  end

  def parse_course_params
    return if params[:course].blank?
    params[:course][:webinar] = (params[:course][:webinar] == "1")
    offset = (cookies()[:utc_offset] || "0").to_i
    timezone = (cookies()[:utc_timezone] || "Europe/Madrid")
    if params[:course][:date]
      split_date = params[:course][:date].split(" - ")
      params[:course][:start_date] = helpers.parse_date(split_date[0], true, offset, timezone)
      params[:course][:end_date] = helpers.parse_date(split_date[1], true, offset, timezone)
    end
    if params[:course][:enrollment_date]
      split_date = params[:course][:enrollment_date].split(" - ")
      params[:course][:start_enrollment_date] = helpers.parse_date(split_date[0], true, offset, timezone)
      params[:course][:end_enrollment_date] = helpers.parse_date(split_date[1], true, offset, timezone)
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
