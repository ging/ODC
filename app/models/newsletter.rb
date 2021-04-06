class Newsletter < ApplicationRecord
	serialize :rules
	serialize :design

	validates_presence_of :subject
	validates_presence_of :body
	validates_presence_of :design
	validates_presence_of :recipients

	def self.get_emails_by_rules(rules, count = false)
		if rules.blank?
			users = []
		else
			users = []
			rules.each do |rule|
				newUsers = [] #All rules are OR

				case rule["id"]
				when "course", "webinar"
					if (rule["operator"] == "in") || (rule["operator"] == "not_in")
						usersInCourses = Course.find(rule["value"]).map{|c| c.users}.flatten.uniq
					end
					if rule["operator"] == "in"
						newUsers = usersInCourses
					elsif rule["operator"] == "not_in"
						newUsers = (User.all - usersInCourses)
					elsif rule["operator"] == "is_null"
						#Users that did not enroll in any course
						newUsers = (User.all - Course.all.map{|c| c.users}.flatten.uniq)
					elsif rule["operator"] == "not_null"
						newUsers = Course.all.map{|c| c.users}.flatten.uniq
					end
				when "category"
					coursesWithCategories = Course.all.select{|c| !c.categories.nil? && (c.categories & rule["value"]).length > 0}
					usersInCoursesWithCategories = coursesWithCategories.blank? ? [] : coursesWithCategories.map{|c| c.users}.flatten.uniq
					if rule["operator"] == "in"
						newUsers = usersInCoursesWithCategories
					elsif rule["operator"] == "not_in"
						newUsers = (User.all - usersInCoursesWithCategories)
					end
				when "email"
					usersWithEmails = User.where(:email => rule["value"].gsub(/\s+/, "").split(";"))
					if rule["operator"] == "equal"
						newUsers = usersWithEmails
					elsif rule["operator"] == "not_equal"
						newUsers = (User.all - usersWithEmails)
					end
				when "all"
					users = User.all
				else
					#Ignore rule
				end
				users = (users + newUsers).uniq
			end
		end

		users = users.uniq.select{|u| u.subscribed_to_newsletters == true}

		return users.count if count
		return users.map { |u| u.email }.join(";")
	end

end