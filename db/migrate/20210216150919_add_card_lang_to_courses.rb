class AddCardLangToCourses < ActiveRecord::Migration[5.2]
  def change
  	add_column :courses, :card_lang, :string, :default => "es"
  end
end
