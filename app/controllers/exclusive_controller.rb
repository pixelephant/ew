class ExclusiveController < ApplicationController
	layout "application"

	def hungaroring
		@title = "Exkluzív hírdetési ajánlat a Hungaroringre"
		@description = "Exkluzív hírdetési ajánlat a Hungaroringre!"
		render "hungaroring"
	end

	def fcbarcelona
		@title = "Eddzen együtt az FC Barcelona edzőivel"
		@description = "5 napon át, 90 perces edzés (reggel) az FC Barcelona profi edzőivel."
		render "barcelona"
	end

end
