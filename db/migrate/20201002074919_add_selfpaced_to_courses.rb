class AddSelfpacedToCourses < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :selfpaced, :boolean
  end
end