class AddClickToTravelTimes < ActiveRecord::Migration
  def up
		change_table :travel_times do |t|
      t.integer :click
		end
  end

	def down
		remove_column :travel_times, :click
	end
end
