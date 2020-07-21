class AddEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.belongs_to :course
      t.belongs_to :user
      t.datetime :date
      t.timestamps
    end
  end
end
