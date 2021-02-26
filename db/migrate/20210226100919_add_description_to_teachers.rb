class AddDescriptionToTeachers < ActiveRecord::Migration[5.2]
  def change
    rename_column :course_teachers, :position, :position_es
  	add_column :course_teachers, :position_en, :string
    add_column :course_teachers, :position_ca, :string
    rename_column :course_teachers, :bio, :bio_es
    add_column :course_teachers, :bio_en, :string
    add_column :course_teachers, :bio_ca, :string
  end
end
