namespace :db do

	#bundle exec rake db:populate
	task :populate => :environment do
		desc "Populate database for a development environment"
		t1 = Time.now

		#Create roles
		Rake::Task["db:populate:roles"].invoke

		#Create demo user
		user = User.new
		user.roles.push(Role.user)
		user.email = "demo@upm.es"
		user.password = "demonstration"
		user.username = "Demo"
		user.ui_language = I18n.default_locale
		user.confirmed_at = DateTime.now
		user.skip_confirmation!
		user.save!
		puts "User '" + user.username + "' created with email '" + user.email + "' and password 'demonstration'"

		#Create admin user
		admin = User.new
		admin.roles.push(Role.admin)
		admin.email = "admin@upm.es"
		admin.password = "demonstration"
		admin.username = "Admin"
		admin.ui_language = I18n.default_locale
		admin.confirmed_at = DateTime.now
		admin.skip_confirmation!
		admin.save!
		puts "User '" + admin.username + "' created with email '" + admin.email + "' and password 'demonstration'"

		#Create courses
		Course.create! :name => "Conciencia ecológica",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 4.5,
			:start_date => DateTime.new(2021,9,1),
			:end_date => DateTime.new(2021,9,30),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas"

		Course.create! :name => "Ciberseguridad",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 3.6,
			:start_date => DateTime.new(2022,9,1),
			:end_date => DateTime.new(2022,9,30),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas"

		Course.create! :name => "Violencia de género",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 2.5,
			:start_date => DateTime.new(2021,9,1),
			:end_date => DateTime.new(2021,9,30),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas"

		#Create webinars
		Course.create! :name => "React y Redux",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 3.6,
			:start_date => DateTime.new(2021,5,1,5,0),
			:end_date => DateTime.new(2021,6,30,6,0),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas",
			:webinar => true
		
		Course.create! :name => "Big data webinar",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 2.0,
			:start_date => DateTime.new(2021,5,1,5,0),
			:end_date => DateTime.new(2021,6,30,6,0),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas",
			:webinar => true
		
		Course.create! :name => "Cómo usar Moodle",
			:description   => "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
			:rating => 3.0,
			:start_date => DateTime.new(2021,5,1,3,0),
			:end_date => DateTime.new(2021,6,30,4,0),
			:url => "http://moodle.vishub.org",
			:dedication => "50 horas",
			:webinar => true
			
		puts "Populate finished"
		t2 = Time.now - t1
		puts "Elapsed time:" + t2.to_s
	end


	#############
	## Subtasks
	#############

	namespace :populate do

		task :roles => :environment do
			roles = [
				{name:"Admin", value:8},
				{name:"User", value:1}
			]
			roles.each do |role|
				r = Role.find_by_name(role[:name])
				if r.nil?
					puts "Creating new role: " + role[:name]
					Role.create!  :name  => role[:name], :value => role[:value]
				end
			end
		end

	end

end