class AddNewsletterFieldToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :subscribed_to_newsletters, :boolean, :default => true
  end
end