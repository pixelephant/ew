class Country < ActiveRecord::Base
	belongs_to :destination

	has_many :regions
	has_many :cities
end
