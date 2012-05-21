class Region < ActiveRecord::Base
	belongs_to :destination

	has_many :cities
	belongs_to :country
end
