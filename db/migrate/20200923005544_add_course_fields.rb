class AddCourseFields < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :alt_link, :string
  	add_column :courses, :retransmission, :string
  end
end
