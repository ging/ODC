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
    params[:webinar] = (params[:webinar]=="true") unless params[:webinar].blank?
    params[:available] = (params[:available]=="true") unless params[:available].blank?
    teacher = [params[:teacher].to_i] unless params[:teacher].blank?  
    categories = [params[:category]] unless params[:category].blank?  
    @searching = true
    SearchSystem.search({
      :query => params[:q], 
      :locale => I18n.locale.to_s, 
      :webinar => params[:webinar], 
      :categories => categories, 
      :available => params[:available], 
      :order => params[:sort_by], 
      :page => params[:page], 
      :per_page => 24, 
      :teacher_ids => teacher
    })
  end

  def teacher_search
    @teachers = SearchSystem.search({:models => [CourseTeacher], :query => params[:q], :per_page => 24})
    render :json => @teachers.map{|t| t.public_json }
  end  
end
