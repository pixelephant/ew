class ListController < ApplicationController
	layout "application"

	def index
		@traveloffers = TravelOffer.all
		render "index"
	end

end
