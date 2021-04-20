class AddNewsletters < ActiveRecord::Migration[5.2]
  def change
  	create_table :newsletters do |t|
      t.text :subject
      t.text :body
      t.text :rules
      t.text :design
      t.text :recipients
      t.timestamps
    end
  end
end
