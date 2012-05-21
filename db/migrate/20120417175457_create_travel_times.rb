class CreateTravelTimes < ActiveRecord::Migration
  def change
    create_table :travel_times do |t|
    	t.integer :id
        t.integer :travel_offer_id
    	t.datetime :from_date
    	t.datetime :to_date
    	t.datetime :price_expire
    	t.string :price_measure
    	t.integer :night
    	t.integer :day
    	t.integer :price
    	t.boolean :discount
    	t.string :service
    	t.integer :bed
    	t.integer :reservation_fee
    	t.integer :transfer_fee
    	t.integer :service_fee
    	t.integer :visa_fee
    	t.integer :airport_tax
    	t.string :storno_insurance
    	t.string :bpp
    	t.integer :kerosene_charge
    	t.boolean :individual
    	t.string :travel_time_type_name
    	t.string :travel_time_type_code
    	t.integer :departure_city_id
    	t.text :note
      t.timestamps
    end
  end
end
