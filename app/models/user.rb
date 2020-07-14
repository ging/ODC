class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

	include Taggable
	acts_as_ordered_taggable

	has_and_belongs_to_many :courses

	before_save :fillTags
	before_save :save_tag_array_text

	validates_presence_of :name

	def files
		self.documents + self.scormfiles
	end

end