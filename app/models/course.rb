class Course < ApplicationRecord
	serialize :categories

	has_and_belongs_to_many :users
	has_attached_file :thumb, 
		styles: { medium: "800x600>", thumb: "300x200>" }, 
		default_url: "/img/course_placeholder.png"
	has_attached_file :powered_by_logo, 
		styles: { medium: "300x300>", thumb: "100x100>" }
	
	validates_attachment :thumb, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :powered_by_logo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	def self.webinars
		Course.where(:webinar => true)
	end
end
