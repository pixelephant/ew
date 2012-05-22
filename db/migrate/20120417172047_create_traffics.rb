class CreateTraffics < ActiveRecord::Migration
  def change
    create_table :traffics do |t|
    	t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
