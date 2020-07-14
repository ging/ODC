module UsersHelper
	def current_user_path_for(resources)
		return user_path(current_user) + "/" + resources
	end
	def resource_name
	  :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end
end
