class OutpricesTravelTimes < ActiveRecord::Migration
  def change
    create_table :outprices_travel_times do |t|
    	t.integer :outprice_id
    	t.integer :travel_time_id
      t.timestamps
    end
  end
end
