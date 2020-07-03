class ApplicationController < ActionController::Base
	before_action :set_variables

	def set_variables
		@isLoggedIn = true
		@user = {
			:name => "Sonsoles López Pernas",
			:email => "sonsoles.lopez.pernas@upm.es",
			:admin => true,
			:photo_file_name => "foto.png",
			:photo_file_path => "https://picsum.photos/120/120?random=2",
			:tags => "Etiqueta 1,Etiqueta 2,Etiqueta 3",
			:events => [
				{:title => "Webinar 1", :date =>  DateTime.yesterday, :duration => "2 h", :language => "Español"},
				{:title => "Webinar 2", :date =>  DateTime.now, :duration => "3 h", :language => "Español"},
				{:title => "Webinar 3", :date =>  Date.parse("01/07/2020 22:00 GMT"), :duration => "3 h", :language => "Español"}, 
				{:title => "Webinar 4", :date =>  Date.parse("01/07/2020 23:00 GMT"), :duration => "3 h", :language => "Español"}
			],
			:courses => [
				{:id => 1, :name => "Conciencia ecológica", :rating=> 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Ciberseguridad", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "VISH Editor", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Programación web", :rating=> 3.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Ciberseguridad", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Conciencia ecológica", :rating=> 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
			]
		}
	end
	
end
