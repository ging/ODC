module NewsletterHelper
	def get_users_by_course_rules(rules, count = false)
		return Newsletter.get_emails_by_rules(rules, count)
	end
end