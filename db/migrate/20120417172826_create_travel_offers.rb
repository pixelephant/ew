class CreateTravelOffers < ActiveRecord::Migration
  def change
    create_table :travel_offers do |t|
    	t.string :md5
    	t.integer :id
    	t.integer :partner_id
    	t.string :travel_name
    	t.string :szallas_name
    	t.integer :category_standard
    	t.string :category_aleph
    	t.integer :board_id
        t.integer :traffic_id
    	t.string :gallery_url
    	t.text :gmap
      t.timestamps
    end
  end
end
