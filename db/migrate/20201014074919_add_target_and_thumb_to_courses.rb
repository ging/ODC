class AddTargetAndThumbToCourses < ActiveRecord::Migration[5.2]
  def change
  	change_table :courses do |t|
  	  t.text :target_audience
      t.attachment :thumb_min
    end
  end
  def self.down
    remove_attachment :courses, :thumb_min
  end
end