class SearchController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  skip_authorization_check :only => [:index]

  RESULTS_SEARCH_PER_PAGE=24

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

    params[:page] = (params[:page] || 1)

    query = "%#{(params[:q]||"").downcase}%"

    params[:sort_by] = "start_date" if !params[:sort_by]
    case params[:sort_by]
    when 'start_date'
      order = 'start_date DESC'
    else
      #order by relevance
      order = nil
    end

    
    results = Course.all

    results = results.where(["lower(name) LIKE ? OR lower(description) LIKE ?", query, query]) unless query.blank?
    results = results.where(:webinar => params[:webinar]) if params[:webinar].present?
    results = results.paginate(:per_page => RESULTS_SEARCH_PER_PAGE, :page => params[:page])
    
    results
  end
  
end