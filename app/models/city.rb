class City < ActiveRecord::Base
	belongs_to :country
	belongs_to :region
	belongs_to :destination
end
