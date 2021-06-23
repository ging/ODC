class AddCourseSimilarities < ActiveRecord::Migration[5.2]
  def change
  	create_table :course_similarities do |t|
		t.belongs_to :course_a, :class_name => "Course"
		t.belongs_to :course_b, :class_name => "Course"
		t.decimal :value, :precision => 12, :scale => 6
		t.boolean :same_course_type
    end
  end
end
