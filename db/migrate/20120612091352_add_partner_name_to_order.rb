class AddPartnerNameToOrder < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
      t.string :partner_name
		end
  end
end
