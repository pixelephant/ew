class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.integer :id
    	t.integer :travel_time_id
    	t.integer :adult
    	t.integer :children
    	t.string :name
    	t.string :phone
    	t.string :email
      t.timestamps
    end
  end
end
