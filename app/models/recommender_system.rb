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

end
