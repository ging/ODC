class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  #GET /resource/sign_in
  def new
    if ODC::Application.config.APP_CONFIG["IDM"].blank?
      super
    else
      redirect_to user_idm_omniauth_authorize_path
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    if !session["devise.idm_data"].nil?
      if current_user
        sign_out(current_user)
      end
      client_id = ODC::Application.config.APP_CONFIG["IDM"]["app_id"]
      redirect_to "#{ODC::Application.config.APP_CONFIG["IDM"]["signout_url"]}#{client_id}"
    else
      super
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
