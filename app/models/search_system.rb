# encoding: utf-8

class SearchSystem

  # Usage example: SearchSystem.search({:query=>"cibersecurity", :per_page=>10, :page => 2})
  def self.search(options={})
    query = ThinkingSphinx::Query.escape(options[:query]) unless options[:query].blank?

    #Specify search options
    sOpts = {}
    sOpts[:classes] = options[:models] || [Course]
    
    #Number of results and pagination
    sOpts[:page] = options[:page].blank? ? 1 : options[:page].to_i
    sOpts[:per_page] = options[:per_page].blank? ? 10000 : options[:per_page].to_i
    
    #Ranking
    sOpts[:ranker] = :proximity_bm25
    sOpts[:field_weights] = {
      :name => 3,
      :description => 1,
      :lessons_text => 1,
      :categories_text => 1
    }

    #Filters
    sOpts[:with] = {}
    sOpts[:with_all] = {}
    if(options[:open] == true || options[:open] == false)
      sOpts[:with][:open] = options[:open]
    end
    if(options[:course] == true || options[:course] == false)
      options[:webinar] = !options[:course];
    end
    if(options[:webinar] == true || options[:webinar] == false)
      sOpts[:with][:webinar] = options[:webinar]
    end
    unless options[:teacher_ids].blank?
      sOpts[:with_all][:teacher_ids] = options[:teacher_ids]
    end
    unless options[:categories].blank?
      options[:categories] = [options[:categories]] unless options[:categories].is_a? Array
      options[:categories_ids] = options[:categories].map{|c| Utils.id_for_category(c)}.compact
      options[:categories_ids] = [-1] if options[:categories_ids].blank?
    end
    unless options[:categories_ids].blank?
      sOpts[:with_all][:categories_ids] = options[:categories_ids]
    end
    unless options[:locale].blank?
      options[:locale_id] = Utils.id_for_locale(options[:locale])
      options[:locale_id] = -1 if options[:locale_id].nil?
    end
    unless options[:locale_id].blank?
      sOpts[:with][:locale_id] = options[:locale_id]
    end

    #By default, Sphinx sorts the results by how relevant they are to the search query
    case options[:order]
    when "date"
      sOpts[:order] = 'start_date DESC'
    else
    end

    return ThinkingSphinx.search query, sOpts
  end

end