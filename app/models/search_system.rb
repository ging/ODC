# encoding: utf-8

class SearchSystem

  # Usage example: SearchSystem.search({:query=>"cibersecurity", :per_page=>10, :page => 2})
  def self.search(options={})
    query = ThinkingSphinx::Query.escape(options[:query]) unless query.blank?

    #Specify search options
    sOpts = {}
    sOpts[:classes] = options[:models] || [Course]
    sOpts[:ranker] = :proximity_bm25
    sOpts[:page] = options[:page].blank? ? 1 : options[:page].to_i
    sOpts[:per_page] = options[:per_page].blank? ? 10000 : options[:per_page].to_i

    return ThinkingSphinx.search query, sOpts
  end

end