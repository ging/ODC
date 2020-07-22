# encoding: utf-8

class RecommenderSystem

  def self.getRecommendCourses(course,n=4)
    if course.categories.blank?
      suggestions = default_suggested_courses(course)
    else
      suggestions = Course.where("webinar = ? and categories is NOT NULL and id != ?", course.webinar, course.id).select{|c| (c.categories & course.categories).length > 0}
      suggestions = default_suggested_courses(course) if suggestions.blank?
    end
    suggestions.sample(n)
  end

  def self.default_suggested_courses(course)
    Course.where("webinar = ? and id != ?", course.webinar, course.id)
  end

end