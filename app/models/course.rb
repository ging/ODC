class Course < ApplicationRecord
	serialize :categories
	serialize :contents
	serialize :teachers_order

	has_and_belongs_to_many :teachers, :class_name => "CourseTeacher"
	has_many :enrollments, dependent: :destroy
	has_many :users, through: :enrollments
	has_many :ratings, :class_name => "CourseRating"

	has_attached_file :teaching_guide
	has_attached_file :thumb, 
		styles: { medium: "1105x700>", thumb: "316x200>" }, 
		default_url: "/img/course_placeholder.png"
	has_attached_file :powered_by_logo, 
		styles: { medium: "300x300>", thumb: "100x100>" }
	
	validates :spots, :numericality => true, :allow_nil => true

	validates_numericality_of :spots, greater_than_or_equal_to: 0, :allow_nil => true

	validates :webinar, inclusion: { in: [ true, false ], allow_blank: true }
	# validates_presence_of :start_date
	# validates_presence_of :end_date
	validates_presence_of :name
	validates_attachment :teaching_guide, content_type: { content_type: ["application/pdf"] }
	validates_attachment :thumb, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :powered_by_logo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	def self.webinars
		Course.where(:webinar => true)
	end

	def sorted_teachers
		return teachers if self.teachers_order.blank?
		self.teachers.sort_by{|t| self.teachers_order[t.id.to_s].to_i }
	end

	def enroll_user(user)
		return if user.nil? or self.users.include?(user)
		e = Enrollment.new
		e.course = self
		e.user = user
		e.date = Time.now
		e.save
	end

	def unenroll_user(user)
		return if user.nil? or !self.users.include?(user)
		self.enrollments.find_by_user_id(user.id).destroy
	end

	def is_enrollment_period?
		return self.selfpaced == true if self.start_enrollment_date.blank? or self.end_enrollment_date.blank?
		tNow = Time.now
		return ((tNow > self.start_enrollment_date) and (tNow < self.end_enrollment_date))
	end

	def add_rating(user,rating)
		return if user.nil? or rating.blank?
		r = self.ratings.find_by_user_id(user.id) || CourseRating.new
		r.course = self
		r.user = user
		r.value = rating
		r.enrolled = self.users.include?(user)
		r.date = Time.now
		r.save
	end

	def update_rating
		rating = nil 
		unless self.ratings.blank?
			rating = (self.ratings.map{|r| r.value}.sum.to_f)/(self.ratings.length.to_f)
		end
		self.update_column(:rating, rating) if rating != self.rating
	end

end