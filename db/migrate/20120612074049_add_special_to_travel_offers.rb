class AddSpecialToTravelOffers < ActiveRecord::Migration
  def change
  	change_table :travel_offers do |t|
      t.boolean :special
		end
  end
end
