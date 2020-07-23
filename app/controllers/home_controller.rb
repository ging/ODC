class HomeController < ApplicationController
	before_action :authenticate_user!, :except => [:frontpage]
	skip_authorization_check :only => [:frontpage]

	def frontpage
		@user_courses = (user_signed_in? ? current_user.courses.sort_by{|c| current_user.enrollments.find_by_course_id(c.id).date}.reverse[0..3] : [])
		@top_courses = Course.where(:webinar => false).order("VISIT_COUNT DESC").limit(4)
		@top_webinars = Course.where(:webinar => true).order("VISIT_COUNT DESC").limit(4)
		respond_to do |format|
			format.html { render layout: "application" }
		end
	end
end