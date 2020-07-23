class AddCourseRating < ActiveRecord::Migration[5.2]
  def change
  	create_table :course_ratings do |t|
      t.belongs_to :course
      t.belongs_to :user
      t.boolean :enrolled
      t.decimal :value, :precision => 12, :scale => 6
      t.datetime :date
      t.timestamps
    end
  end
end
