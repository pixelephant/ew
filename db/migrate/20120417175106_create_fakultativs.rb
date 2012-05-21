class CreateFakultativs < ActiveRecord::Migration
  def change
    create_table :fakultativs do |t|
    	t.integer :id
    	t.integer :price
    	t.string :length
    	t.string :title
    	t.string :description
      t.timestamps
    end
  end
end
