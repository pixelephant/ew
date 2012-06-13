class TripController < ApplicationController
	layout "application"

	def index
		render "index"
	end

	def show
		@travel_offer = TravelOffer.find(params[:id])

		params[:from_date] ? @closest_travel_time = @travel_offer.travel_times.find_by_slug(params[:from_date]) : @closest_travel_time = @travel_offer.closest_travel_time
		@country = Country.find(@travel_offer.destinations.first.country_id)
		@region = Region.find(@travel_offer.destinations.first.region_id)
		@departure_city = City.find(@closest_travel_time.departure_city_id)
		@images = @travel_offer.images
		@gallery = @travel_offer.gallery_url.to_s
		@travel_times = @travel_offer.travel_times.where('(DATE(travel_times.from_date) > DATE(NOW())) AND travel_times.id <> ' + @closest_travel_time.id.to_s)
		@leiras = @travel_offer.descriptions.where(:name => 'Fekvese').first.description.to_s.html_safe
		@inprices = @travel_offer.inprices
		@fakultativs = @travel_offer.fakultativs

		@similar_offers = @travel_offer.similar_offers
		@travel_attributes = @travel_offer.travel_attributes

		@travel_offer.click = (@travel_offer.click.to_i + 1)
		@travel_offer.save

		render "show"
	end

end
