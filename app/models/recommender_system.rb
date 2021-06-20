# encoding: utf-8

class RecommenderSystem

  def self.getRecommendCourses(course,n=4)
    #filter courses and webinars only in the language of the page, or in spanish if page is in english
    pagelang = I18n.locale.to_s
    if course.categories.blank?
      suggestions = default_suggested_courses(course, pagelang)
    else
	    suggestions = Course.where("webinar = ? and categories is NOT NULL and id != ?", course.webinar, course.id).where(:card_lang => pagelang).select{|c| (c.categories & course.categories).length > 0}
      suggestions = default_suggested_courses(course, pagelang) if suggestions.blank?
    end
    suggestions.sample(n)
  end

  def self.default_suggested_courses(course, pagelang="es")
	  Course.where("webinar = ? and id != ?", course.webinar, course.id).where(:card_lang => pagelang)
  end




  #Utils

  def self.getWordsFromText(text)
    return {} if text.blank?
    text = processText(text)
    words = Hash.new
    text.split(" ").each do |word|
      word = word.gsub(/([.|;|:|,]$)/,"")
      words[word] = 0 if words[word].nil?
      words[word] += 1
    end
    words
  end

  def self.processText(text)
    return "" if text.blank? or !text.is_a? String
    text = ActionView::Base.full_sanitizer.sanitize(text)
    text = I18n.transliterate(text.gsub(/([\n])/," ").gsub(/([.|;|:|,]$)/,"").strip, :locale => "en").downcase
  end

end
