class AddSpecialToImages < ActiveRecord::Migration
  def change
  	change_table :images do |t|
      t.boolean :special
		end
  end
end
