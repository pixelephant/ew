class AddLonglatToDestinations < ActiveRecord::Migration
  def up
		change_table :destinations do |t|
      t.string :lat
      t.string :long
		end
  end

	def down
		remove_column :destinations, :lat
		remove_column :destinations, :long
	end
end
