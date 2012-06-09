class MoveClickToTravelOffers < ActiveRecord::Migration
  def up
		remove_column :travel_times, :click
		change_table :travel_offers do |t|
      t.integer :click
		end
  end

	def down
		remove_column :travel_offers, :click
		change_table :travel_times do |t|
      t.integer :click
		end
	end
end
