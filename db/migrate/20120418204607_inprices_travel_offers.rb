class InpricesTravelOffers < ActiveRecord::Migration
  def change
    create_table :inprices_travel_offers do |t|
    	t.integer :inprice_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
