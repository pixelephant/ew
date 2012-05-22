class CreateOptionalFees < ActiveRecord::Migration
  def change
    create_table :optional_fees do |t|
			t.integer :id
			t.string :name
      t.integer :travel_time_id
    	t.integer :price
    	t.string :price_type
    	t.boolean :optional
    	t.boolean :discount
    	t.integer :category_id
    	t.integer :age_from
    	t.integer :age_to
    	t.date :valid_from
    	t.date :valid_to
      t.timestamps
    end
  end
end
