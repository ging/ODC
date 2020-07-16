class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, :allow_nil => false, :length => { :in => 1..255 }, :uniqueness => { :case_sensitive => false }

  def self.admin
  	Role.find_by_name("Admin")
  end

  def self.user
  	Role.find_by_name("User")
  end

  def self.default
    user
  end

  def readable
    I18n.t("roles."+self.name.downcase, :default => self.name) unless self.name.nil?
  end

end