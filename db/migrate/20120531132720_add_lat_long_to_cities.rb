class AddLatLongToCities < ActiveRecord::Migration
  def up
		remove_column :destinations, :lat
		remove_column :destinations, :long
		change_table :cities do |t|
      t.string :lat
      t.string :long
		end
  end

	def down
		remove_column :cities, :lat
		remove_column :cities, :long
		change_table :destinations do |t|
      t.string :lat
      t.string :long
		end
	end
	
end
