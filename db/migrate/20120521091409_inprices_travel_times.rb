class InpricesTravelTimes < ActiveRecord::Migration
  def change
    create_table :inprices_travel_times do |t|
    	t.integer :inprice_id
    	t.integer :travel_time_id
      t.timestamps
    end
  end
end
