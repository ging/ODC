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
    if @profile_user and can? :update, @profile_user
  		render "edit"
  	else
  		redirect_to "/"
  	end
  end

  def update
  	if @profile_user and can? :update, @profile_user
      if @profile_user.update(users_params.except("avatar_delete"))
        if users_params["avatar_delete"] == "1"
          @profile_user.avatar = nil
        end
        @profile_user.save!
        redirect_to @profile_user, notice: I18n.t("devise.registrations.updated_other")
      else
        flash.now[:alert] = @profile_user.errors.full_messages.join(". ")
        render :edit
      end
  	else
  		redirect_to "/"
  	end
  end
 
  def destroy
  	if @profile_user and can? :destroy, @profile_user
      if @profile_user.destroy
        redirect_to "/", notice: I18n.t("devise.registrations.updated_other")
      else
        flash.now[:alert] = @profile_user.errors.full_messages.join(". ")
        render :edit
      end
  	else
  		redirect_to "/"
  	end
  end


  private

  def find_user
    @profile_user = User.find_by_id(params[:id])
    authorize! :read, @profile_user
    @isProfileOwner = (!@profile_user.nil? and user_signed_in? and current_user.id==@profile_user.id)
  end

  def users_params
    par = params.require(:user).permit("name", "surname","email","password","password_confirmation","tag_list","ui_language","avatar","avatar_delete")
    if par["password"].blank?
      par.except("password").except("password_confirmation")
    else
      par
    end
  end

end