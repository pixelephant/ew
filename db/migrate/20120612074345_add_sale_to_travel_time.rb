class AddSaleToTravelTime < ActiveRecord::Migration
  def change
  	change_table :travel_times do |t|
      t.boolean :sale
		end
  end
end
