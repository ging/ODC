ThinkingSphinx::Index.define :course_teacher, :with => :real_time do
  # fields
  indexes name
  indexes facebook
  indexes linkedin
  indexes twitter
  indexes instagram
  indexes position_es
  indexes bio_es
  indexes position_en
  indexes bio_en
  indexes position_en
  indexes bio_en

  # attributes
  has created_at, :type => :timestamp
end