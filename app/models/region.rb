class Region < ActiveRecord::Base
	has_many :destinations

	has_many :cities
	belongs_to :country
	has_many :skiregions

	attr_accessible :id, :name, :country_id

	default_scope :order => 'name ASC'
end
