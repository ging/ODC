class AddRoles < ActiveRecord::Migration[5.2]
  def change
  	create_table :roles do |t|
      t.string :name
      t.integer :value, :default => 0
      t.timestamps
    end
    create_table :roles_users, :id => false do |t|
      t.references :role, :user
    end
  end
end