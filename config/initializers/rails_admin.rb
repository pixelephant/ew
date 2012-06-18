RailsAdmin.config do |config|

	config.model TravelTime do
		object_label_method do
			:travel_time_label_method
		end
	end

	config.model TravelOffer do
		include_all_fields
		exclude_fields :md5

		field :destinations do 
      associated_collection_cache_all true 
    end 

		object_label_method do
			:travel_offer_label_method
		end
	end

	config.model Destination do
		object_label_method do
			:destination_label_method
		end
	end

	def travel_time_label_method
		self.travel_offer ? self.travel_offer.travel_name : ''
	end

	def travel_offer_label_method
		self ? self.travel_name : ''
	end

	def destination_label_method
		label = ""
		label << (self.country ? self.country.name.to_s : '')
		label << (self.city ? "," + self.city.name.to_s : '')
		return label
	end

end