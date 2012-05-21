class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
			t.integer :id
			t.integer :country_id
			t.string :name
      t.timestamps
    end
  end
end
