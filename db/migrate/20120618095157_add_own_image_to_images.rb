class AddOwnImageToImages < ActiveRecord::Migration
  def change
  	change_table :images do |t|
      t.string :own_image_file
		end
  end
end
