class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
    	t.integer :id
    	t.string :name
    	t.string :email
    	t.string :contact
    	t.integer :offers
    	t.text :info
      t.timestamps
    end
  end
end
