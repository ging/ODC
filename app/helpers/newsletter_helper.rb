module NewsletterHelper
	def get_users_by_course_rules(rules, count = false)

		results = User.left_joins(:courses)

		# TO-DO Fix is_null, not_null - No funciona bien
		rules.each do |rule|
			if rule["id"] == "course" || rule["id"] == "webinar"
				if rule["operator"] == "in"
					results = results.where("courses.id" => rule["value"])
				elsif rule["operator"] == "not_in"
					results = results.where.not("courses.id" => rule["value"])
				elsif rule["operator"] == "is_null"
				 	results = results.group('users.id').where("courses.webinar" => (rule["id"] == "webinar")).having('COUNT(courses.id) = 0');
				elsif rule["operator"] == "not_null"
				 	results = results.group('users.id').where("courses.webinar" => (rule["id"] == "webinar")).having('COUNT(courses.id) > 0');
				end
			elsif rule["id"] == "category"
				if rule["operator"] == "in"
					results = results.where("courses.category" => rule["value"])
				elsif rule["operator"] == "not_in"
					results = results.where.not("courses.category" => rule["value"])
				end
			elsif rule["id"] == "email"
				if rule["operator"] == "equal"
					results = results.where("id" => rule["value"])
				elsif rule["operator"] == "not_equal"
					results = results.where.not("id" => rule["value"])
				end
			end

		end

		if count
			return results.distinct.count
		else 
			return results.distinct.map { |u| u.email }.join(";")
		end
	end
end