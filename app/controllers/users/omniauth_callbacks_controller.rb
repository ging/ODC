class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController 
  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def idm
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.idm_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # def passthru
  #   super
  # end

  def failure
    redirect_to root_path
  end

  def signout_callback
    if !ODC::Application.config.APP_CONFIG["IDM"].blank?
      redirect_to destroy_user_session_path #/users/sign_out
    else 
      client_id = ODC::Application.config.APP_CONFIG["IDM"]["app_id"]
      redirect_to "#{ODC::Application.config.APP_CONFIG["IDM"]["signout_url"]}#{client_id}"
  end
  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end