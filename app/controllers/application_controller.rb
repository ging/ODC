class ApplicationController < ActionController::Base
	protect_from_forgery
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_locale
	check_authorization :unless => :devise_controller?
	skip_authorization_check :only => [:page_not_found,:terms_of_use]
	before_action :store_location


	#############
  # Last location handling
  #############
  # Store last url. This filter is used for post-login redirect to whatever the user last visited.
  def store_location
    if (
      request.get? && #only store get requests
      request.format == "text/html" &&   #if the user asks for a specific resource .jpeg, .png etc do not redirect to it
      !request.xhr? && # don't store ajax calls
      !request.path_info.include?("/users/")  #for any authentication avoid ERR_TOO_MANY_REDIRECTS
    )
      session[:user_return_to] = request.fullpath
    end
  end



	def set_locale
		I18n.locale = extract_locale_from_params || extract_locale_from_user_profile || extract_locale_from_session || extract_locale_from_webclient || I18n.default_locale
	end

	#############
	# CORS
	# Methods to enable CORS (http://www.tsheffler.com/blog/?p=428)
	#############

	# If this is a preflight OPTIONS request, then short-circuit the
	# request, return only the necessary headers and return an empty
	# text/plain.
	def cors_preflight_check
		if request.method.downcase.to_sym == :options
			headers['Access-Control-Allow-Origin'] = '*'
			headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
			headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
			headers['Access-Control-Max-Age'] = '1728000'
			render :text => '', :content_type => 'text/plain'
		end
	end

	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
		headers['Access-Control-Max-Age'] = "1728000"
	end

	def allow_iframe_requests
		response.headers.delete('X-Frame-Options')
	end

	#Rescue for authorization errors
	rescue_from CanCan::AccessDenied do |exception|
		flash[:alert] = I18n.t("authorization.errors.generic")
		redirect_to "/"
	end

	#Wildcard route rescue
	def page_not_found
		respond_to do |format|
			format.html {
				if request.path.include?("assets/") or request.xhr?
					render :text => I18n.t("dictionary.errors.page_not_found"), :status => '404'
				else
					redirect_to view_context.home_path, alert: I18n.t("dictionary.errors.page_not_found")
				end
			}
			format.full {
				if request.path.include?("assets/") or request.xhr?
					render :text => I18n.t("dictionary.errors.page_not_found"), :status => '404'
				else
					redirect_to view_context.home_path, alert: I18n.t("dictionary.errors.page_not_found")
				end
			}
			format.json {
				render json: I18n.t("dictionary.errors.page_not_found")
			}
		end
	end

	def terms_of_use
		render "layouts/_terms"
	end

	def after_sign_in_path_for(resource)
  	request.env['omniauth.origin'] || root_url
	end

	protected

	def configure_permitted_parameters

		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
			user_params.permit(:email, :password, :password_confirmation, :username, :name, :surname, :language, :ui_language, :tag_list, :avatar)
		end
		devise_parameter_sanitizer.permit(:account_update) do |user_params|
			user_params.permit(:email, :password, :password_confirmation, :current_password, :username, :name, :surname, :language, :ui_language, :tag_list, :avatar, :avatar_delete)
		end
	end

	private

	def extract_locale_from_params
		params[:locale] if Utils.valid_locale?(params[:locale])
	end

	def extract_locale_from_user_profile
		current_user.ui_language if (user_signed_in? and Utils.valid_locale?(current_user.ui_language))
	end

	def extract_locale_from_session
		session[:locale] if Utils.valid_locale?(session[:locale])
	end

	def extract_locale_from_webclient
		unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
			client_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
			return (Utils.valid_locale?(client_locale) ? client_locale : nil)
		end
	end



end
