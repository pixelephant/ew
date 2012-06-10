class AddNoteToOrder < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
      t.text :note
		end
  end
end
