class HomeController < ApplicationController
	layout "application"

	def index
		@regions = []
		@cities = []
		
		@specials = TravelOffer.where(:special => 1).limit(9)
		@popular = Destination.joins(:travel_offers).select("destinations.country_id").order("travel_offers.click DESC").group("destinations.country_id").limit(5)

		render "index"
	end

end
