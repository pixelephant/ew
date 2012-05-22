class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
    	t.integer :country_id
    	t.integer :region_id
    	t.integer :city_id
      t.timestamps
    end
  end
end
