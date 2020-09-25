class AddPoweredByLink < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :powered_by_link, :string
  end
end
