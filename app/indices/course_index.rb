ThinkingSphinx::Index.define :course, :with => :real_time do
  # fields
  indexes name
  indexes description
  indexes lessons_text
  indexes categories_text

  # attributes
  has date, :type => :timestamp
  has start_date, :type => :timestamp
  has end_date, :type => :timestamp
  has created_at, :type => :timestamp
  has available, :type => :boolean
  has webinar, :type => :boolean
  has teacher_ids, :type => :integer, :multi => true
  has categories_ids, :type => :integer, :multi => true
  has locale_id, :type => :integer
  has ranking, :type => :integer
end