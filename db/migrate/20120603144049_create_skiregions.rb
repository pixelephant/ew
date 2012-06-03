class CreateSkiregions < ActiveRecord::Migration
  def change
    create_table :skiregions do |t|
			t.integer :id
    	t.integer :region_id
    	t.integer :country_id
    	t.string :name
      t.timestamps
    end
  end
end
