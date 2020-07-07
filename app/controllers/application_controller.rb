class ApplicationController < ActionController::Base
	before_action :set_variables

	def set_variables
		@isLoggedIn = true
		@user = {
			:name => "Sonsoles López Pernas",
			:email => "sonsoles.lopez.pernas@upm.es",
			:admin => true,
			:photo_file_name => "foto.png",
			:photo_file_path => "https://picsum.photos/120/120?random=2"
		}
	end
	
end
