class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
			t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
