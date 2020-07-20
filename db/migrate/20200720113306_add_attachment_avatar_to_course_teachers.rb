class AddAttachmentAvatarToCourseTeachers < ActiveRecord::Migration[5.2]
  def self.up
    change_table :course_teachers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :course_teachers, :avatar
  end
end