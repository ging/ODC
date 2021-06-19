ThinkingSphinx::Index.define :course, :with => :real_time do
  # fields
  indexes name
  indexes description

  # attributes
  has selfpaced,  :type => :boolean
  has start_date, :type => :timestamp
  has end_date, :type => :timestamp
end