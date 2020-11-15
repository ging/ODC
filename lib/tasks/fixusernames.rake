#this task is executed as follows:
#bundle exec rake odc:fixusernames RAILS_ENV=production
namespace :odc do
	task :fixusernames => :environment do
		desc "Fixing usernames"
		puts "Fixing usernames"

		#array with duplicates
    dups = User.select("COUNT(username) as total, username").group(:username).having("COUNT(username) > 1").to_a
		puts "ENCONTRADOS!!: " + dups.count.to_s
		dups.each {|u| fix_dup(u)}
		#fix_dup("Victoria")

		puts "Task finished"
	end

	def fix_dup(userrelation)
		puts userrelation.username + " con " + userrelation.total.to_s
		username = userrelation.username
		ar = User.where(username: username).to_a.drop(1)
		ar.each { |a|
			newusername = a.email.split("@").first
			puts "Arreglando " + a.username + " con nuevo username: " + newusername
			#if already taken, select another
			if User.where(username: newusername).exists?
				puts "El username " + newusername + " estaba cogido, añadimos un 1..."
				newusername = newusername + "1"
			end
			a.username = newusername
			begin
				a.save!
			rescue
				puts "EL USERNAME " + a.username + " SE HA QUEDADO SIN SALVAR"
			end
		}
	end

end
