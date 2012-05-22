class CreateInprices < ActiveRecord::Migration
  def change
    create_table :inprices do |t|
    	t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
