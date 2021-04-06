class NewslettersController < ApplicationController
	load_and_authorize_resource :except => [:builder, :calculate_newsletter_recipients]
	skip_authorization_check :only => [:builder, :calculate_newsletter_recipients]
	before_action :set_newsletter, only: [:show, :destroy]

	def index
		@newsletters = Newsletter.all
	end

	def show
		@newsletter = Newsletter.find(params[:id])
	end

	def new
		@courses = Course.where(:webinar => false).map{ |c| {"id" => c.id, "name" => c.name} }
		@webinars= Course.where(:webinar => true).map { |c| {"id" => c.id, "name" => c.name} }
		@categories = I18n.t('categories').map { |name,cat| {"id" => name, "name" => cat} }

		if params[:template]
			@template = Newsletter.find_by_id(params[:template])
		end
	end

	def builder
		render "builder", layout: false
	end

	def calculate_newsletter_recipients
		begin
			rules = params["to"]["rules"] rescue []
			to = {:count => Newsletter.get_emails_by_rules(rules,true)}
			render json: to
		rescue
			to = {:count => 0, :msg => "Error" }
			render json: to
		end
	end

	def create
		begin
			email = params[:email]
			rules = JSON.parse(email[:to])["rules"] rescue []
			to = Newsletter.get_emails_by_rules(rules)

			#Save newsletter
			Newsletter.create! :subject   => email[:subject],
				:body => email[:body],
				:rules => rules,
				:design => email[:design],
				:recipients => to

			NewsletterMailer.newsletter_email(to, email[:subject], email[:body]).deliver_now
			redirect_to "/", notice: "E-mail sent successfully"
		rescue
		  flash[:alert] = "E-mail could not be sent"
		  redirect_to "/newsletter"
		end
	end

	def destroy
		@newsletter.destroy
		redirect_to "/newsletters", notice:  "Newsletter succesfully destroyed"
	end


	private

	def set_newsletter
		@newsletter = Newsletter.find(params[:id])
	end

end