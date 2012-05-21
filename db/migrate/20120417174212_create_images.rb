class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.integer :travel_offer_id
    	t.string :file_name
      t.timestamps
    end
  end
end
