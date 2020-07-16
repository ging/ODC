class Course < ApplicationRecord
	has_and_belongs_to_many :users

	def self.webinars
		Course.where(:webinar => true)
	end
end
