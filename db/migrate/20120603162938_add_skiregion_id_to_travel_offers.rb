class AddSkiregionIdToTravelOffers < ActiveRecord::Migration
  def up
		change_table :travel_offers do |t|
      t.integer :skiregion_id
		end
  end

	def down
		remove_column :travel_offers, :skiregion_id
	end
end
