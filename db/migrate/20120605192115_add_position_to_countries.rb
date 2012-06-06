class AddPositionToCountries < ActiveRecord::Migration
  def up
		change_table :countries do |t|
      t.integer :position
		end
  end

	def down
		remove_column :countries, :position
	end
end
