class AddTravelTextToOrder < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
      t.text :travel_text
		end
  end
end
