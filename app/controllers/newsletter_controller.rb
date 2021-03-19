class NewsletterController < ApplicationController
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
			NewsletterMailer.newsletter_email(email["to"], email["subject"],  email["content"]).deliver_now
			redirect_to "/", notice: "E-mail sent successfully" 
		rescue e
		  flash[:error] = "E-mail could not be sent"
		  redirect_to "/newsletter"
		end
		
	end
end