class CreateDestinationsTravelOffers < ActiveRecord::Migration
  def change
    create_table :destinations_travel_offers do |t|
    	t.integer :destination_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
