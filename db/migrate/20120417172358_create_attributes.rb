class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
			t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
