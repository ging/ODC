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
    @teachers = SearchSystem.search({:models => [CourseTeacher], :query => params[:q], :per_page => 24})
    render :json => @teachers.map{|t| t.public_json }
  end

end
