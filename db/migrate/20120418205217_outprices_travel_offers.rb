class OutpricesTravelOffers < ActiveRecord::Migration
  def change
    create_table :outprices_travel_offers do |t|
    	t.integer :outprice_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
