class AddLonglatToDestinations < ActiveRecord::Migration
  def up
		change_table :destinations do |t|
      t.string :lat, :null => false
      t.string :long, :null => false
		end
  end

	def down
		remove_column :destinations, :lat
		remove_column :destinations, :long
	end
end
