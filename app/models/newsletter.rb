class Newsletter < ApplicationRecord
	serialize :rules
	serialize :design

	validates_presence_of :subject
	validates_presence_of :body
	validates_presence_of :design
	validates_presence_of :recipients

	def self.get_emails_by_rules(rules, count = false)
		user = User.left_joins(:courses)

		# TO-DO Fix is_null, not_null - No funciona bien
		rules.each do |rule| 
			if rule["id"] == "course" || rule["id"] == "webinar"
				if rule["operator"] == "in"
					user = user.where("courses.id" => rule["value"])
				elsif rule["operator"] == "not_in"
					user = user.where.not("courses.id" => rule["value"])
				elsif rule["operator"] == "is_null"
				 	user = user.group('users.id').where("courses.webinar" => (rule["id"] == "webinar")).having('COUNT(courses.id) = 0');
				elsif rule["operator"] == "not_null"
				 	user = user.group('users.id').where("courses.webinar" => (rule["id"] == "webinar")).having('COUNT(courses.id) > 0');
				end
			elsif rule["id"] == "category" # Tampoco funciona bien
				if rule["operator"] == "in"
					user = user.where("courses.category" => rule["value"])
				elsif rule["operator"] == "not_in"
					user = user.where.not("courses.category" => rule["value"])
				end
			elsif rule["id"] == "email"
				if rule["operator"] == "equal"
					user = user.where("id" => rule["value"])
				elsif rule["operator"] == "not_equal"
					user = user.where.not("id" => rule["value"])
				end
			end

		end

		user = user.distinct

		
		return user.count if count
		return user.map { |u| u.email }.join(";")
	end

end