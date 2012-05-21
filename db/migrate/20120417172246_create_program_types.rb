class CreateProgramTypes < ActiveRecord::Migration
  def change
    create_table :program_types do |t|
    	t.integer :id
    	t.string :name
      t.timestamps
    end
  end
end
