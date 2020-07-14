class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description 
      t.decimal :rating, :precision => 12, :scale => 6
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :webinar, :default => false
      t.timestamps
    end
    create_table :courses_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
    end
  end
end