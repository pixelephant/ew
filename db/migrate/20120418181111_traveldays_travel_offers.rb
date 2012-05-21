class TraveldaysTravelOffers < ActiveRecord::Migration
  def change
    create_table :travel_offers_traveldays do |t|
    	t.integer :travelday_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
