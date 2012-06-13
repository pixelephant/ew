class Partner < ActiveRecord::Base
	attr_accessible :id, :name, :email, :contact, :info

	has_many :travel_offers
end
