class RenameAttributesTable < ActiveRecord::Migration
   def self.up
   	rename_table :attributes, :travel_attributes
   	rename_table :attributes_travel_offers, :travel_attributes_travel_offers
   	rename_column :travel_attributes_travel_offers, :attribute_id, :travel_attribute_id
   end 
   def self.down
   	rename_table :travel_attributes, :attributes
   	rename_table :travel_attributes_travel_offers, :attributes_travel_offers
   	rename_column :attributes_travel_offers, :travel_attribute_id, :attribute_id
   end
end
