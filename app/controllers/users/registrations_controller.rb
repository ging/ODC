class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_captcha, only: [:create] if  ODC::Application.config.recaptcha


  # GET /resource/sign_up
  def new
    if params[:enroll]
      @course_to_enroll = Course.find_by_id(params[:enroll])
    end
    super
  end

  # POST /resource
  def create
    if params[:enroll]
      @course_to_enroll = Course.find_by_id(params[:enroll])
      if !@course_to_enroll.spots.blank? and (@course_to_enroll.enrollments.length >= @course_to_enroll.spots)
          redirect_to @course_to_enroll, notice: I18n.t("course.errors.overcrowded")
          return
      elsif !@course_to_enroll.is_enrollment_period?
          redirect_to @course_to_enroll, notice: I18n.t("course.errors.not_active")
          return
      end
    end
    build_resource(sign_up_params)

    if resource.has_attribute?(:language) and resource.has_attribute?(:ui_language)
      resource.ui_language = Utils.valid_locale?(resource.language) ? resource.language : I18n.locale.to_s
      resource.language = resource.ui_language if resource.language.blank?
    end

    resource.roles.push(Role.default)

    if params[:terms] != "accept"
      set_flash_message! :notice, :need_to_accept_terms
      redirect_to new_registration_path(resource)

    else
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          if @course_to_enroll.enroll_user(resource)
            redirect_to @course_to_enroll, notice: @course_to_enroll[:webinar] ? I18n.t("webinar.enrollment_success"): I18n.t("course.enrollment_success")
            return
          else
            redirect_to @course_to_enroll, notice: I18n.t("course.errors.enrollment_generic")
            return
          end
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end


  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super(resource,params.except("avatar_delete")) if params["password"]&.present? or params["current_password"]&.present?

    if params["avatar_delete"] == "1"
      resource.avatar = nil
    end

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password").except("avatar_delete"))
  end

  # GET /resource/edit
  # def edit
  #  super
  # end

  # PUT /resource
  # def update
  #  super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     stored_location_for(resource) || root_path
   end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      respond_with_navigational(resource) { render :new }
    end
  end

end
