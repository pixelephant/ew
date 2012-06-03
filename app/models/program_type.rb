class ProgramType < ActiveRecord::Base
	has_and_belongs_to_many :travel_offers

	attr_accessible :id, :name
end
