class AttributesTravelOffers < ActiveRecord::Migration
  def change
    create_table :attributes_travel_offers do |t|
    	t.integer :attribute_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
