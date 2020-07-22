class CourseTeacher < ActiveRecord::Base
	include Taggable
	acts_as_ordered_taggable

	has_attached_file :avatar, 
		styles: { medium: "300x300>", thumb: "100x100>" }, 
		default_url: "/img/user_placeholder.png"

	has_and_belongs_to_many :courses

	before_save :fillTags
	before_save :save_tag_array_text

	validates :name, presence: true, uniqueness: true, allow_nil: false
	validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	# Alias for acts_as_taggable_on :tags
	acts_as_taggable
	def as_json(*)
	  super.merge(:avatar => avatar.as_json).except("created_at", "updated_at").tap do |hash|
	    hash["label"] = "#{name} (#{position})"
	  end
	end

end