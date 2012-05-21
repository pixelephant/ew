class ProgramTypesTravelOffers < ActiveRecord::Migration
  def change
    create_table :program_types_travel_offers do |t|
    	t.integer :program_type_id
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
