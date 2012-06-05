class AddTravelTimesIdToChildPrices < ActiveRecord::Migration
  def up
		change_table :child_prices do |t|
      t.integer :travel_time_id
		end
  end

	def down
		remove_column :child_prices, :travel_time_id
	end
end
