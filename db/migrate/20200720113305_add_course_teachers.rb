class AddCourseTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :course_teachers do |t|
      t.string :name
      t.string :position
      t.string :facebook
      t.string :linkedin
      t.string :twitter
      t.string :instagram
      t.text :bio
      t.timestamps
    end
    create_table :course_teachers_courses, id: false do |t|
      t.belongs_to :course_teacher, index: true
      t.belongs_to :course, index: true
    end
  end
end
