class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  skip_authorization_check :only => [:show,:index,:edit,:new,:create,:update]
  # GET /courses
  def index
    query = "%#{(params[:query]||"").downcase}%"

    @courses = Course

    @courses = @courses.where(:webinar => params[:webinar] == "1") if !params[:webinar].blank?
    @courses = @courses.where(["lower(name) LIKE ? OR lower(description) LIKE ?", query,query])
      .paginate(:per_page => 24, :page => params[:page].blank? ? 1 : params[:page])
  end

  # GET /courses/1
  def show
  end


  # GET /courses/new
  def new
    @course = Course.new
    @course.webinar = params[:webinar] == "1"
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @course.webinar = params[:course][:webinar] == "1"
    if params[:course][:date] 
      split_date = params[:course][:date].split(" - ")
      @course.start_date = parse_date(split_date[0], @course.webinar)
      @course.end_date = parse_date(split_date[1], @course.webinar)
    end
    if @course.save
      redirect_to @course, notice: I18n.t("course.successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if params[:course][:date] 
      split_date = params[:course][:date].split(" - ")
      params[:course][:start_date] = helpers.parse_date(split_date[0], @course.webinar)
      params[:course][:end_date] = helpers.parse_date(split_date[1], @course.webinar)
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:name,:description,:start_date,:end_date,:format,:video,:type,:dedication,:powered_by,:lang,:url,:teachers,:contents,:lessons)
    end
end