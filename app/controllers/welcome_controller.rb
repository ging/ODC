class WelcomeController < ApplicationController
  
  def search
  	@courses = [
	  	{:name => "Conciencia ecológica", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Big data webinar", :rating=> 4.5, :thumb => "https://picsum.photos/380/200?random=2", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating=> 5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Violencia de género", :rating=> 3.1, :thumb => "https://picsum.photos/380/200?random=4", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Uso seguro de las TIC", :rating=> 2.3, :thumb => "https://picsum.photos/380/200?random=5", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :rating=> 3.1, :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Matemáticas", :rating=> 3.1, :thumb => "https://picsum.photos/380/200?random=8", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	  ]
	
	@searching = true
  end
  def index
  	@top_webinars = [
	  	{:name => "Big data webinar", :rating=> 3.5, :thumb => "https://picsum.photos/380/200?random=2", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Violencia de género", :rating=> 4.5, :thumb => "https://picsum.photos/380/200?random=4", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :rating=> 3.2, :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Matemáticas", :rating=> 4.9, :thumb => "https://picsum.photos/380/200?random=8", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]

  	@top_courses = [
	  	{:name => "Conciencia ecológica", :rating=> 4.5, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Uso seguro de las TIC", :rating=> 3.3, :thumb => "https://picsum.photos/380/200?random=5", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :rating=> 3.5, :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]

  	@my_courses = [
	  	{:name => "Conciencia ecológica", :rating=> 4.7, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :rating=> 4.5, :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :rating=> 3.5, :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]
  end
  def course
	@course = {   
		:name => "Conciencia ecológica", 
  		:thumb => "https://picsum.photos/380/200?random=1", 
  		:from => "01/02/2020", 
  		:duration => 50400,
  		:to=>"09/09/2021", 
  		:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
  		:rating=> 3.5,
		:lang => "Español",
		:powered_by => "Cisco",
		:lessons => "11 (50 min.)",
		:type => "MOOC",
		:contents => [
			{:title=> "Tema 1: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
			{:title=> "Tema 2: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]},
			{:title=> "Tema 3: Lorem Ipsum",:topics => ["Apartado 1", "Apartado 2", "Apartado 3"]}
		],
		:tags => ["Uso seguro de las TIC", "Ciberseguridad"],
		:teachers => [
			{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
			{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
		],
		:enrolled => true,
		:webinar => false,
  		:desc=> "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
  	}
  	@related_courses = [
	  	{:name => "Conciencia ecológica", :rating => 4.5, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating => 2.5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :rating => 4, :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :rating => 3.5, :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]
  end

  def webinar
	@webinar = {   
		:name => "Conciencia ecológica", 
  		:thumb => "https://picsum.photos/380/200?random=1", 
  		:platform_img => "https://www3.gobiernodecanarias.org/educacion/cau_ce/servicios/web/sites/www3.gobiernodecanarias.org.educacion.cau_ce.servicios.web/files/inline-images/webex_0.png",
  		:date => "30/06/2020 21:33 GMT", 
  		:duration => 120,
  		:video=> "https://www.youtube.com/embed/Y3ywicffOj4",
  		:rating=> 3.5,
		:lang => "Español",
		:powered_by => "Cisco",
		:visits => 449,
		:interested_users => 2098,
		:tags => ["Uso seguro de las TIC", "Ciberseguridad"],
		:teachers => [
			{:name => "Juan Quemada Vives", :position => "Profesor de la UPM", :photo=> "https://picsum.photos/120/120?random=1", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "juan-q", :instagram =>"jq", :twitter => "jq", :facebook=>"jw"},
			{:name => "Joaquín Salvachúa Rodríguez", :position => "Profesor de la UPM", :photo=> "https://picsum.photos/120/120?random=2", :bio=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ni", :linkedin=> "jsalvachua", :instagram =>"jsr"}
		],
		:webinar => false,
  		:desc=> "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro <b>quisquam</b> est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>"
  	}
  	@related_webinars = [
	  	{:name => "Conciencia ecológica", :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]
  end

  def profile
  	@my_courses = [
	  	{:name => "Conciencia ecológica", :rating=> 4.7, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "VISH Editor", :rating=> 4.5, :thumb => "https://picsum.photos/380/200?random=6", :from => "01/02/2020", :to=>"09/09/2021", :webinar => true, :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Programación web", :rating=> 3.5, :thumb => "https://picsum.photos/380/200?random=7", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Ciberseguridad", :rating=> 2.5, :thumb => "https://picsum.photos/380/200?random=3", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."},
	  	{:name => "Conciencia ecológica", :rating=> 4.7, :thumb => "https://picsum.photos/380/200?random=1", :from => "01/02/2020", :to=>"09/09/2021", :desc=> "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."}
	]
  end
end
