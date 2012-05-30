class AddContinentToCountry < ActiveRecord::Migration
  def up
		change_table :countries do |t|
      t.string :continent
		end
  end

	def down
		remove_column :countries, :continent
	end
end
