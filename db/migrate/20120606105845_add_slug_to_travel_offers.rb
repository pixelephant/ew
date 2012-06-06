class AddSlugToTravelOffers < ActiveRecord::Migration
  def change
  	change_table :travel_offers do |t|
      t.string :slug
		end
		add_index :travel_offers, :slug, unique: true
  end
end
