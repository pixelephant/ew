class TripController < ApplicationController
	layout "application"

	def index

		@program_types = ProgramType.all
		@regions = []
		@cities = []

		render "index"
	end

end
