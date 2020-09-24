namespace :odc do
	#bundle exec rake odc:rebuild
	#bundle exec rake odc:rebuild RAILS_ENV=production
	task :rebuild do
		desc "Rebuild"
		system "rake odc:reset"
		system "rake db:populate"
		puts "Rebuild finished"
	end

	task :reset do
		desc "Reset"
		system "rake db:drop"
		system "rake db:create"
		system "rake db:migrate"
		system "rm -rf documents/*"
		system "rm -rf public/system/*"
		system "rm -rf public/tmp/*"
		puts "Reset finished"
	end
end