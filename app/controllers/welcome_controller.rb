class WelcomeController < ApplicationController
	skip_before_action :verify_authenticity_token  

	# GET /courses/search
	# Returns the top 20 courses that match the query criteria (params[:query])
	def search_courses
		query = params[:query]
		# Use gems: will_paginate & bootstrap-will_paginate (for the view)
      
		# Query 
		@courses = [
			{:id=> 1, :name => "Conciencia ecológica", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Big data webinar", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=2", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => false, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Ciberseguridad", :rating=> 5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Violencia de género", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=4", :from => "01/02/2020", :to=>"09/09/2021", :webinar => false, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Uso seguro de las TIC", :rating=> 2.3, :photo_file_path => "https://picsum.photos/380/200?random=5", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "VISH Editor", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => false, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Programación web", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Matemáticas", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=8", :from => "01/02/2020", :to=>"09/09/2021", :webinar => false, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]

		@searching = true # Do not show search bar in navbar since it is already on the main content of the page
		render template: "welcome/search"
	end

	# GET /webinars/search
	# Returns the top 20 webinars that match the query criteria (params[:query])
	def search_webinars
		query = params[:query]
		# Use gems: will_paginate & bootstrap-will_paginate (for the view)
	     
		# Query 
		@courses = [
			{:id=> 1, :name => "Big data webinar", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=2", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Ciberseguridad", :rating=> 5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Violencia de género", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=4", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Uso seguro de las TIC", :rating=> 2.3, :photo_file_path => "https://picsum.photos/380/200?random=5", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "VISH Editor", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Programación web", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id=> 1, :name => "Matemáticas", :rating=> 3.1, :photo_file_path => "https://picsum.photos/380/200?random=8", :from => "01/02/2020 11:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]

		@searching = true # Do not show search bar in navbar since it is already on the main content of the page
		render template: "welcome/search"
	end

	# GET /
	# Main page
	def index
		# If the user is  logged in we need to load his/her courses and webinars
		if @isLoggedIn
			@user[:courses] = [
				{:id => 1, :name => "Conciencia ecológica", :rating=> 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Ciberseguridad", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "VISH Editor", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020 10:30", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Programación web", :rating=> 3.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Ciberseguridad", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
				{:id => 1, :name => "Conciencia ecológica", :rating=> 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
			]
		end

		# Top 4 webinars
		@top_webinars = [
			{:id => 1, :name => "Big data webinar", :rating=> 3.5, :photo_file_path => "https://picsum.photos/380/200?random=2", :from => "01/02/2020 10:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Violencia de género", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=4", :from => "01/02/2020 10:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "VISH Editor", :rating=> 3.2, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020 10:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Matemáticas", :rating=> 4.9, :photo_file_path => "https://picsum.photos/380/200?random=8", :from => "01/02/2020 10:00", :to=>"09/09/2021 12:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]

		# Top 4 courses
		@top_courses = [
			{:id => 1, :name => "Conciencia ecológica", :rating=> 4.5, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Ciberseguridad", :rating=> 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Uso seguro de las TIC", :rating=> 3.3, :photo_file_path => "https://picsum.photos/380/200?random=5", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Programación web", :rating=> 3.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]
	end

	# GET /course/:id
	# Course information page
	def course
		# @course = Course.find(params[:id])
		@course = {   
			:id => 1,
			:name => "Conciencia ecológica", 
			:photo_file_path => "https://picsum.photos/380/200?random=1", 
			:from => "01/02/2020", 
			:to=>"09/09/2021", 
			:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
			:rating=> 3.5,
			:lang => "Español",
			:guide_file_name => "guia.pdf",
			:guide_file_path => "/a.pdf",
			:powered_by => "Cisco",
			:duration => "5 semanas",
			:lessons => "11 (50 min.)",
			:type => "mooc",
			:contents => [
				{:title=> "Tema 1: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 2: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 3: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]}
			],
			:tags => ["environment"],
			:teachers => [
				{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
				{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
			],
			:enrolled => true,
			:webinar => false,
			:desc=> "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
		}

		@related_courses = [
			{:id => 1, :name => "Conciencia ecológica", :rating => 4.5, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Ciberseguridad", :rating => 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "VISH Editor", :rating => 4, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Programación web", :rating => 3.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]
	end

	# GET /course/new
	# New course page
	def new_course
		@course = {}
	end

	# GET /course/:id/edit
	# Edit course page
	def edit_course
		@course = {   
			:id => 1,
			:name => "Conciencia ecológica", 
			:photo_file_path => "https://picsum.photos/800/400?random=1", 
			:from => "01/02/2020", 
			:to =>"09/09/2021", 
			:duration => "5 semanas",
			:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
			:url => "https://miriadax.net/web/html5mooc",
			:rating => 3.5,
			:lang => "Español",
			:guide_file_name => "guia.pdf",
			:guide_file_path => "/a.pdf",
			:powered_by => "Cisco",
			:lessons => "11 (50 min.)",
			:type => "mooc",
			:contents => [
				{:title=> "Tema 1: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 2: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 3: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]}
			],
			:tags => ["environment"],
			:teachers => [
				{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
				{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
			],
			:enrolled => true,
			:webinar => false,
			:desc => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
		}
	end

	# POST /course
	# Create course
	def create_course
		puts request.body.read
		id = 1
		redirect_to "/course/#{id}"
	end

	# PUT /course/:id
	# Edit course
	def update_course
		puts request.body.read
		id = 1
		redirect_to "/course/#{id}"
	end

	# GET /webinar/:id
	# Webinar information page
	def webinar
		# @webinar = Webinar.find(params[:id])
		@webinar = {   
			:id => 1,
			:name => "Conciencia ecológica", 
				:photo_file_path => "https://picsum.photos/380/200?random=1", 
				:platform_img => "https://www3.gobiernodecanarias.org/educacion/cau_ce/servicios/web/sites/www3.gobiernodecanarias.org.educacion.cau_ce.servicios.web/files/inline-images/webex_0.png",
				:from => "30/06/2020 11:30", 
				:to => "30/06/2020 12:30", 
				:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
				:rating=> 3.5,
			:lang => "Español",
			:powered_by => "Cisco",
			:visits => 449,
			:interested_users => 2098,
			:tags => ["environment"],
			:teachers => [
				{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
				{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
			],
			:webinar => false,
			:desc=> "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
		}

		@related_webinars = [
			{:id => 1, :name => "Conciencia ecológica", :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020 10:00" , :to=>"09/09/2021 11:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Ciberseguridad", :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020 9:00", :to=>"09/09/2021 11:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "VISH Editor", :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020 9:00", :to=>"09/09/2021 11:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Programación web", :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020 9:00", :to=>"09/09/2021 11:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]
	end

	
	# GET /webinar/new
	# New webinar page
	def new_webinar
		@webinar = {:webinar => true}
	end
	
	# POST /webinar/
	# Create webinar
	def create_webinar
		puts request.body.read
		id = 1
		redirect_to "/webinar/#{id}"
	end
	
	# GET /webinar/:id
	# Edit webinar page
	def edit_webinar
		@webinar = {   
			:id => 1,
			:name => "Conciencia ecológica", 
			:photo_file_path => "https://picsum.photos/800/400?random=1", 
			:from => "30/06/2020 11:30", 
			:to => "30/06/2020 12:30",
			:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
			:url => "https://miriadax.net/web/html5mooc",
			:rating => 3.5,
			:lang => "Español",
			:powered_by => "Cisco",
			:lessons => "11 (50 min.)",
			:type => "mooc",
			:contents => [
				{:title=> "Tema 1: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 2: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
				{:title=> "Tema 3: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]}
			],
			:tags => ["environment"],
			:teachers => [
				{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
				{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo_file_path=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
			],
			:webinar => true,
			:desc => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
		}
	end
	# PUT /webinar/:id
	# Update webinar
	def update_webinar
		puts request.body.read
		id = 1
		redirect_to "/webinar/#{id}"
	end

	# GET /profile
	# User profile
	def profile
	  	@user[:tags] = "Etiqueta 1,Etiqueta 2,Etiqueta 3"
		@user[:events] = [
			{:title => "Webinar 1", :from => "30/06/2020 11:30", :to => "30/06/2020 12:30", :language => "Español"},
			{:title => "Webinar 2", :from => "30/06/2020 11:30", :to => "30/06/2020 12:30", :language => "Español"},
			{:title => "Webinar 3", :from => "30/07/2020 14:30", :to => "30/07/2020 18:30", :language => "Español"}, 
			{:title => "Webinar 4", :from => "30/07/2020 11:30", :to => "30/07/2020 12:30", :language => "Español"}
		]
		@user[:courses] = [
			{:id => 1, :name => "Conciencia ecológica", :rating => 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Ciberseguridad", :rating => 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "VISH Editor", :rating => 4.5, :photo_file_path => "https://picsum.photos/380/200?random=6", :from => "01/02/2020 9:00", :to=>"09/09/2021 11:00", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Programación web", :rating => 3.5, :photo_file_path => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Ciberseguridad", :rating => 2.5, :photo_file_path => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
			{:id => 1, :name => "Conciencia ecológica", :rating => 4.7, :photo_file_path => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
		]
  	end
  
	# GET /register
	# Registration page
	def new_user
		@isLoggedIn = false
		@user = {}
	end

	# GET /profile/edit
	# Edit user profile
	def edit_user
		@user[:tags] = "Etiqueta 1,Etiqueta 2,Etiqueta 3"
		@user[:events] = [
			{:title => "Webinar 1", :from => "30/06/2020 11:30", :to => "30/06/2020 12:30", :language => "Español"},
			{:title => "Webinar 2", :from => "30/06/2020 11:30", :to => "30/06/2020 12:30", :language => "Español"},
			{:title => "Webinar 3", :from => "30/07/2020 14:30", :to => "30/07/2020 18:30", :language => "Español"}, 
			{:title => "Webinar 4", :from => "30/07/2020 11:30", :to => "30/07/2020 12:30", :language => "Español"}
		]
	end

	# PUT /profile/edit
	# Update user information
	def update_user
		puts params[:user]
		redirect_to "/profile"
	end

	# POST /register
	# Create new user
	def create_user
		puts params[:user]
		redirect_to "/profile"
	end

	# POST /forgot
	# Send email to restore password
	def forgot
		email = params[:email]

		# ... Send an email to the user to restore their password

		render json: {msg: 'OK'} # If everything goes OK
		# render json: {msg: 'EMAIL_NOT_FOUND'} # If no user exists for that email
		# render json: {msg: 'ERROR_SENDING_EMAIL'} # If the email cannot be sent
		# render json: {msg: 'ERROR'} # If there's another error
	end
end
