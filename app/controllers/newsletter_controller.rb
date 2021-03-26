class NewsletterController < ApplicationController
	include  NewsletterHelper
	skip_authorization_check
	def index
		render "index"
	end

	def builder
		render "builder", layout: false
	end

	def send_newsletter
		begin
			email = params[:email]
			rules = JSON.parse(email[:to])["rules"] rescue []
			to = get_users_by_course_rules(rules)
			NewsletterMailer.newsletter_email(to, email["subject"],  email["content"]).deliver_now
			redirect_to "/", notice: "E-mail sent successfully" 
		rescue

		  flash[:error] = "E-mail could not be sent"
		  redirect_to "/newsletter"
		end
		
	end

	def calculate_newsletter_recipients
		begin
			rules = params["to"]["rules"] rescue []
			to = {:count => get_users_by_course_rules(rules, true)}
			render json: to
		rescue
			to = {:count => 0, :msg => "Error" }
			render json: to
		end

	end
end