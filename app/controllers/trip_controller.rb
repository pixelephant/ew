class TripController < ApplicationController
	layout "application"

	def index
		render "index"
	end

	def show
		@travel_offer = TravelOffer.find(params[:id])
		@closest_travel_time = @travel_offer.closest_travel_time
		@country = Country.find(@travel_offer.destinations.first.country_id)
		@region = Region.find(@travel_offer.destinations.first.region_id)
		@images = @travel_offer.images
		@gallery = @travel_offer.gallery_url.to_s

		render "show"
	end

end
