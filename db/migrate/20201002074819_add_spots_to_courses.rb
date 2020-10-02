class AddSpotsToCourses < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :spots, :integer
  end
end
