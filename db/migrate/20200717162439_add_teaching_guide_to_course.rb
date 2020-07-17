class AddTeachingGuideToCourse < ActiveRecord::Migration[5.2]
  def self.up
    change_table :courses do |t|
      t.attachment :teaching_guide
    end
  end

  def self.down
    remove_attachment :courses, :teaching_guide
  end
end
