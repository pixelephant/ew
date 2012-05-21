class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
			t.integer :id
			t.integer :country_id
			t.integer :region_id
			t.string :name
      t.timestamps
    end
  end
end
