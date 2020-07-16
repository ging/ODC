class AddAttachmentsToCourses < ActiveRecord::Migration[5.2]
  def self.up
    change_table :courses do |t|
      t.attachment :thumb
      t.attachment :powered_by_logo
    end
  end

  def self.down
    remove_attachment :courses, :thumb
    remove_attachment :courses, :powered_by_logo
  end
end
