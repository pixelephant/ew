RailsAdmin.config do |config|

	config.model TravelTime do
		object_label_method do
			:travel_time_label_method
		end
	end

	config.model TravelOffer do
		include_all_fields
		exclude_fields :md5
	end

	def travel_time_label_method
		self.travel_offer.travel_name
	end

end