class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

	include Taggable
	acts_as_ordered_taggable

	has_attached_file :avatar, 
		styles: { medium: "300x300>", thumb: "100x100>" }, 
		default_url: "/img/user_placeholder.png"

	has_and_belongs_to_many :roles
	has_and_belongs_to_many :courses

	before_save :fillTags
	before_save :save_tag_array_text

	validates_presence_of :name
	validates :roles, :presence => { :message => I18n.t("dictionary.errors.blank") }
	validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	# Alias for acts_as_taggable_on :tags
	acts_as_taggable


	def files
		self.documents + self.scormfiles
	end

	def readable_role
    	self.role.readable unless self.role.nil?
  	end


  	#Role Management

	def role
		self.sort_roles.first
	end

	def sort_roles
		self.roles.sort_by{|r| r.value}.reverse
	end

	def role_name
		role.name unless role.nil?
	end

	def role?(roleName)
		return !!self.roles.find_by_name(roleName.to_s.camelize)
	end

	def isAdmin?
		return self.role?("Admin")
	end

	def assignRole(newRole,delete=true)
		return if self.role?("Admin") or newRole.nil?
		self.roles.delete_all if delete
		self.roles.push(newRole)
	end

	def addRole(newRole)
		assignRole(newRole,false)
	end

	def canChangeRole?(user, newRole)
		return false unless self.isAdmin?
		return false unless self.role.value > user.role.value or self.id == user.id
		return false unless !newRole.nil? and self.role.value >= newRole.value
		return true
	end

	def self.admins
		Role.admin.users.uniq
	end

	def self.users
		Role.user.users
	end

end