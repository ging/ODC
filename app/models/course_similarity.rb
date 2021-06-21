class CourseSimilarity < ActiveRecord::Base
  validates :value, :presence => true
  validates :course_a_id, :presence => true
  validates :course_b_id, :presence => true
  validates_uniqueness_of :course_a_id, scope: :course_b_id
  validate :course_ids
  attr_accessor :course_id

  def course_ids
	errors.add(:course_a_id, 'course_a_id should not be higher than course_b_id') unless course_a_id < course_b_id
  end

  def self.getSimilarity(cA,cB)
	r = CourseSimilarity.where(:course_a_id => [cA.id,cB.id].min, :course_b_id => [cA.id,cB.id].max).first
	r.value.to_f unless r.nil
  end

end