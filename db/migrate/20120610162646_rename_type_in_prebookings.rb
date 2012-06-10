class RenameTypeInPrebookings < ActiveRecord::Migration
  def change
  	rename_column :pre_bookings, :type, :amount_type
  end
end