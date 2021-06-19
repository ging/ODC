ThinkingSphinx::Index.define :course, :with => :real_time do
  # fields
  indexes name
  indexes description
  indexes lessons_text
  indexes categories_text

  # attributes
  has start_date, :type => :timestamp
  has open, :type => :boolean
  has webinar, :type => :boolean
  has teacher_ids, :type => :integer, :multi => true
  has categories_ids, :type => :integer, :multi => true
end