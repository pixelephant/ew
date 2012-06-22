class AddSlugToCountries < ActiveRecord::Migration
  def change
  	change_table :countries do |t|
      t.string :slug
		end
		add_index :countries, :slug, unique: true
  end
end
