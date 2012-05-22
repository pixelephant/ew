class CreateChildPrices < ActiveRecord::Migration
  def change
    create_table :child_prices do |t|
    	t.integer :age_from
    	t.integer :age_to
    	t.string :bed_type
    	t.string :price_type
    	t.integer :price
      t.timestamps
    end
  end
end
