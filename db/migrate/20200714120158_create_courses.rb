class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description 
      t.decimal :rating, :precision => 12, :scale => 6
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_enrollment_date
      t.datetime :end_enrollment_date
      t.boolean :webinar, :default => false
      t.string :video
      t.string :lang
      t.string :url
      t.string :powered_by
      t.string :dedication
      t.string :lessons
      t.string :format
      t.text :categories
      t.text :contents
      t.text :teachers_order
      t.timestamps
    end
    create_table :courses_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
    end
  end
end