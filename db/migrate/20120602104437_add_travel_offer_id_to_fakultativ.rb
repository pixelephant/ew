class AddTravelOfferIdToFakultativ < ActiveRecord::Migration
  def up
		change_table :fakultativs do |t|
      t.integer :travel_offer_id
		end
  end

	def down
		remove_column :fakultativs, :travel_offer_id
	end
end
