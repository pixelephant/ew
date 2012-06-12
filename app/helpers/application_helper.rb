# encoding: utf-8

module ApplicationHelper

	def monthsForSelect
		#return select_month(Date.today, :use_month_names => %w(Január Február Március Április Május Június Július Augusztus Szeptember Október November December))
		return month = [['Január', 1],['Február', 2],['Március', 3],['Április', 4],['Május', 5],['Június', 6],['Július', 7],['Augusztus', 8],['Szeptember', 9],['Október', 10],['November', 11],['December', 12]]
	end

	def periodsForSelect
		return period = [['Tavaszi szünet', 13],['Nyáron', 14]]
	end

	def special_image(travel_offer_id)
		image = Image.where(:travel_offer_id => travel_offer_id).order("images.special DESC").limit(1).first
		return TravelOffer.find(travel_offer_id).gallery_url.to_s + image.file_name.to_s
	end

end
