class AddSlugToTravelTimes < ActiveRecord::Migration
  def change
  	change_table :travel_times do |t|
      t.string :slug
		end
		add_index :travel_times, :slug, unique: true
  end
end
