class ApplicationController < ActionController::Base
	before_action :set_variables

	def set_variables
		@isLoggedIn = true
		@user = {
			:name => "Sonsoles López Pernas",
			:img => "https://picsum.photos/120/120?random=2",
			:tags => ["Etiqueta 1","Etiqueta 2","Etiqueta 3"],
			:events => [
				{:title => "Webinar 1", :date =>  DateTime.yesterday, :duration => "2 h", :language => "Español"},
				{:title => "Webinar 2", :date =>  DateTime.now, :duration => "3 h", :language => "Español"},
				{:title => "Webinar 3", :date =>  Date.parse("01/07/2020 22:00 GMT"), :duration => "3 h", :language => "Español"}, 
				{:title => "Webinar 4", :date =>  Date.parse("01/07/2020 23:00 GMT"), :duration => "3 h", :language => "Español"}
			]
		}
	end
	
end
