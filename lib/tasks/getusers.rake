require 'csv'

#this task is executed as follows:
#bundle exec rake odc:getusers[COURSEID] RAILS_ENV=production
#bundle exec rake odc:getusers[29] RAILS_ENV=production
#the output is saved to folder: 
namespace :odc do
	task :getusers, [:courseid] => :environment do |t, args|
		desc "Getting users enrolled in course: " + args[:courseid]
		puts "Getting users enrolled in course: " + args[:courseid]
		file = "#{Rails.root}/course_"+args[:courseid]+"_user_data.csv"

		users = Course.find(args[:courseid]).users

		headers = ["Nombre", "Apellidos", "Email"]

		CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
		  users.each do |u|
			  writer << [u.name, u.surname, u.email]
		  end
		end
		puts "Task finished, your file is at: " + file
	end

end
