class CreateOutprices < ActiveRecord::Migration
  def change
    create_table :outprices do |t|
			t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
