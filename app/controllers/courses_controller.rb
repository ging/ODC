class CoursesController < ApplicationController
  load_and_authorize_resource :except => [:webinars, :all_courses]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :parse_course_params, only: [:create, :update]
  skip_authorization_check :only => [:webinars, :all_courses]
  after_action :save_and_update_teachers, only: [:create, :update]
  
  # GET /courses
  def index
    @courses = Course.where(:webinar => false).paginate(:per_page => 24, :page => params[:page].blank? ? 1 : params[:page])
  end

  # GET /webinars
  def webinars
    @courses = Course.webinars.paginate(:per_page => 24, :page => 1)
    render "index"
  end

  # GET /all_courses
  def all_courses
    @courses = Course.all.paginate(:per_page => 24, :page => 1)
    render "index"
  end

  # GET /courses/1
  def show
    @related_courses = Course.where(:webinar => @course.webinar).where("id != :id", id: @course.id).limit(4)
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
    if @course.save
      redirect_to @course, notice: I18n.t("course.successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: I18n.t("course.successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice:  I18n.t("course.successfully_destroyed")
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name,:description,:start_date,:end_date,:format,:video,:type,:dedication,:powered_by,:powered_by_logo,:teaching_guide,:lang,:url,:lessons,:thumb, categories: [], contents: [:title, topics: []], teachers_order: [])
  end

  def teachers_params
    params.require(:course).permit(teachers: [:id, :name, :position, :facebook, :linkedin, :twitter, :instagram, :bio, :order, :avatar])
  end

  def parse_course_params
    return if params[:course].blank?
    params[:course][:webinar] = (params[:course][:webinar] == "1")
    if params[:course][:date] 
      split_date = params[:course][:date].split(" - ")
      params[:course][:start_date] = helpers.parse_date(split_date[0], @course.webinar)
      params[:course][:end_date] = helpers.parse_date(split_date[1], @course.webinar)
    end
  end

  def save_and_update_teachers
    @course.teachers = []
    teachers_order = {}

    teachers_params["teachers"].each do |teacherParams|
      teacher = CourseTeacher.find_by_id(teacherParams["id"]) || CourseTeacher.new

      teacher.assign_attributes(teacherParams.reject{|k,v| k=="order"})

      if teacher.save
        @course.teachers.push(teacher)
        teachers_order[teacher.id.to_s] = teacherParams[:order] unless teacherParams[:order].blank?
      end
    end

    unless teachers_order.blank?
      @course.teachers_order = teachers_order
      @course.save
    end
  end
end