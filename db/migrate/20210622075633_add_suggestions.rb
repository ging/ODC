class AddSuggestions < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :suggestions, :text
    add_column :users, :course_suggestions, :text
    add_column :users, :webinar_suggestions, :text
  end
end