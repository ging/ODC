class HomeController < ApplicationController
	before_action :authenticate_user!, :except => [:frontpage]
	skip_authorization_check :only => [:frontpage]

	def frontpage
		@user_courses = (user_signed_in? ? current_user.courses : [])
		@top_courses = Course.where(:webinar => false)
		@top_webinars = Course.where(:webinar => true)
		respond_to do |format|
			format.html { render layout: "application" }
		end
	end
end