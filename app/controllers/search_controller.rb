class SearchController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  skip_authorization_check :only => [:index, :teacher_search]

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
    @searching = true
    params.delete_if { |k, v| v == "" }

    params[:page] = (params[:page] || 1)

    query = "%#{(params[:q]||"").downcase}%"

    params[:sort_by] = "start_date" if !params[:sort_by]
    # case params[:sort_by]
    # when 'start_date'
    #   order = 'start_date DESC'
    # else
    #   order = nil
    # end
    results = Course.all
    results = results.where(["lower(name) LIKE ? OR lower(description) LIKE ? OR lower(categories) LIKE ?", query, query, sanitize(query)]) unless query.blank?
    results = results.where(:webinar => params[:webinar]) if params[:webinar].present?
    #filter courses and webinars only in the language of the page
    pagelang = I18n.locale.to_s
    results = results.where(:card_lang => pagelang)
    results = results.order(:start_date=> :desc,:end_date=> :desc, :created_at=> :desc).paginate(:per_page => RESULTS_SEARCH_PER_PAGE, :page => params[:page])
    results
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
