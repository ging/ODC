class HomeController < ApplicationController
	before_action :authenticate_user!, :except => [:frontpage, :help, :about]
	skip_authorization_check :only => [:frontpage, :help, :about]

	def frontpage
		@user_courses = (user_signed_in? ? current_user.courses.sort_by{|c| current_user.enrollments.find_by_course_id(c.id).date}.reverse[0..3] : [])
		#filter courses and webinars only in the language of the page, or in spanish if page is in english
		pagelang = I18n.locale.to_s
		@top_courses = Course.where(:webinar => false).where(:card_lang => pagelang).order("VISIT_COUNT DESC").limit(4)
		@top_webinars = Course.where(:webinar => true).where(:card_lang => pagelang).order("VISIT_COUNT DESC").limit(4)
		respond_to do |format|
			format.html { render layout: "application" }
		end
	end

	def help
		render :help
	end

	def about
		render :about
	end
end
