class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
    	t.integer :id
    	t.integer :country_id
    	t.string :content
      t.timestamps
    end
  end
end
