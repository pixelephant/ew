#encoding: utf-8
class ExclusiveController < ApplicationController
	layout "application"

	caches_page :hungaroring, :fcbarcelona, :gyorietovip

	def hungaroring
		@title = "Exkluzív hírdetési ajánlat a Hungaroringre - "
		@description = "Exkluzív hírdetési ajánlat a Hungaroringre!"
		render "hungaroring"
	end

	def fcbarcelona
		@title = "Eddzen együtt az FC Barcelona edzőivel - "
		@description = "5 napon át, 90 perces edzés (reggel) az FC Barcelona profi edzőivel."
		render "barcelona"
	end

	def gyorietovip
		@title = "Győri ETO FC stadion VIP páholyok értékesítése! - "
		@description = "Győri ETO FC stadion VIP páholyok értékesítése!"
		render "gyorietovip"
	end

end
