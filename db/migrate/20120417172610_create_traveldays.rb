class CreateTraveldays < ActiveRecord::Migration
  def change
    create_table :traveldays do |t|
			t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
