class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:idm]

    include Taggable
    acts_as_ordered_taggable

    serialize :course_suggestions
    serialize :webinar_suggestions

    has_attached_file :avatar,
        styles: { medium: "300x300>", thumb: "100x100>" },
        default_url: "/img/user_placeholder.png"

    has_and_belongs_to_many :roles
    has_many :enrollments, dependent: :destroy
    has_many :courses, through: :enrollments

    before_save :fillTags
    before_save :save_tag_array_text
    before_create :set_default_username 


    #validates_presence_of :username
    #validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates_presence_of :email
    validates_presence_of :name
    validates_presence_of :encrypted_password
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

    def self.from_omniauth(auth)
        email = nil

        case auth.provider
        when "github"
            email = auth["extra"]["raw_info"]["email"]
        when "idm"
            email = auth["extra"]["raw_info"]["email"]
        else
            email = auth["extra"]["raw_info"]["email"] rescue nil
        end

        user = find_by_email(email)
        return user unless user.nil?


        #User does not exist in BBDD, create it.
        u = User.new(provider: auth.provider, uid: auth.uid)
        u.email = email
        u.password = Devise.friendly_token[0,20]
        u.roles.push(Role.default)

        case auth.provider
        when "github"
            u.name = auth["extra"]["raw_info"]["name"]
        when "idm"
            u.name = auth["extra"]["raw_info"]["name"]
        else
            u.name = auth["extra"]["raw_info"]["name"] rescue nil
        end

        u.save!
        return u
    end

    protected
    def confirmation_required?
      false
    end

    private

  def set_default_username
    str = self.name.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        gsub(/\s/,'_').
        tr("-", "_").
        downcase
    ascii = I18n.transliterate(str)
    self.username ||= "#{ascii}-#{User.last.id+1}"
  end

end
