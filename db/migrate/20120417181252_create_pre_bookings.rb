class CreatePreBookings < ActiveRecord::Migration
  def change
    create_table :pre_bookings do |t|
      t.integer :travel_time_id
    	t.datetime :start_date
    	t.datetime :end_date
    	t.string :type
    	t.integer :amount
    	t.text :description
      t.timestamps
    end
  end
end
