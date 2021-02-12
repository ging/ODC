class UsersController < ApplicationController
  before_action :find_user, :except => [:index]
  skip_authorization_check :only => [:index]

  def index
    if current_user and current_user.isAdmin?
      render "index"
    else
      redirect_to "/"
    end
  end
  def show
  end

  def edit
  	if @isProfileOwner or current_user.isAdmin?
  		render "edit"
  	else
  		redirect_to "/"
  	end
  end

  def update
  	if @isProfileOwner or current_user.isAdmin?
      update_resource = Users::RegistrationsController.new
      update_resource.request = request
      update_resource.response = response
      params = users_params
      resp = update_resource.update_resource(@profile_user,params)
      puts resp
      if (resp)
        render "show", notice: I18n.t("devise.registrations.updated_other")
      else
        render "edit", notice: I18n.t("devise.registrations.failed_to_update_other")
      end
  	else
  		redirect_to "/"
  	end
  end
 
  def destroy
  	if @isProfileOwner or current_user.isAdmin?
  		@profile_user.destroy
      if (@profile_user.destroy)
        redirect_to "/", notice: I18n.t("devise.registrations.updated_other")
      else
        render "edit", notice: I18n.t("devise.registrations.failed_to_update_other")
      end
  	else
  		redirect_to "/"
  	end
  end


  private

  def find_user
    @profile_user = User.find_by_id(params[:id]) 
    authorize! :read, @profile_user
    if !@profile_user.nil? and user_signed_in?
    	@isProfileOwner = (user_signed_in? and current_user.id==@profile_user.id)
    else
      redirect_to "/"
    end
  end

  def users_params
    params.require(:user).permit("name", "surname","email","current_password","password","password_confirmation","tag_list","ui_language","avatar","avatar_delete")
  end

end