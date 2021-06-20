class SearchController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  skip_authorization_check :only => [:index, :teacher_search]

  def index
    @courses = search

    respond_to do |format|
      format.html {
        render "courses/index"
      }
    end
  end


  def search
    #Remove empty params
    params.delete_if { |k, v| v == "" }
    params[:sort_by] = "date" if !params[:sort_by]
    params[:webinar] = (params[:webinar]==1) unless params[:webinar].blank?

    @searching = true

    SearchSystem.search({:query => params[:q], :locale => I18n.locale.to_s, :webinar => params[:webinar], :per_page => 24, :page => params[:page], :order => params[:sort_by]})
  end

  def teacher_search
    query = "%#{(params[:term]||"").downcase}%"
    results = CourseTeacher.all
    results = results.where(["lower(name) LIKE ?", query]) unless query.blank?
    results = results.paginate(:per_page => 5, :page => 1)
    if results.length == 0
      results = [{:label => I18n.t("course.teacher.no_results"), :value =>"default"}]
    end
    render :json => results
  end

end
