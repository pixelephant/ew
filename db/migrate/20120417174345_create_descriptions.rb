class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
			t.string :name
    	t.text :description
    	t.integer :travel_offer_id
      t.timestamps
    end
  end
end
