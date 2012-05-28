class AjaxController < ApplicationController

	include Rack::Utils

	def get_region
		id = params[:id]
		r = Region.where(:country_id => id)
		c = City.where(:country_id => id)

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :region => r.as_json, :city => c.as_json}
			}
		end
	end

	def get_city
		id = params[:id]
		country_id = params[:country_id]

		if id.to_i > 0
			c = City.where(:region_id => id)
		else
			c = City.where(:country_id => country_id)
		end

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :data => c.as_json}
			}
		end
	end

	def search_estimate
		
		data = parse_nested_query(params[:data])
		form_vals = data["search"]
		
		country = form_vals["country"]
		region = form_vals["region"]
		city = form_vals["city"]
		arrival = form_vals["arrival"]
		departure = form_vals["departure"]
		max_price = form_vals["max_price_text"]
		flexibility = form_vals["flexibility"]
		no_date = form_vals["no_date"]
		imprecise = form_vals["imprecise"]

		c = []

		if no_date.to_i == 0
			if flexibility.to_i > 0
				unless arrival.blank?
					a = arrival
					t = Time.parse(a)
					tfrom = t - (flexibility.to_i).days
					tto = t + (flexibility.to_i).days
					c << "travel_times.from_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "'"
				end
				unless departure.blank?
					a = departure
					t = Time.parse(a)
					tfrom = t - (flexibility.to_i).days
					tto = t + (flexibility.to_i).days
					c << "travel_times.to_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "'"
				end
			else
				(c << ('travel_times.from_date = ' + arrival)) unless arrival.blank?
				(c << ('travel_times.to_date = ' + departure)) unless departure.blank?
			end

			(c << ('destinations.city_id = ' + city)) unless (city.blank? || city.to_i == 0)
			(c << ('destinations.region_id = ' + region)) unless (region.blank? || region.to_i == 0)
			(c << ('destinations.country_id = ' + country)) unless (country.blank? || country.to_i == 0)
		end
		if no_date.to_i == 1
			im = imprecise.to_i
			if im > 0 && im < 13
				if Date.today.month.to_i > im
					d = (Date.today.year.to_i + 1).to_s + "-" + im.to_s
				else
					d = Date.today.year.to_s + "-" + im.to_s
				end
				dstart = d + "-01"
				dend = d + "-31"
			end
			c << ("travel_times.from_date > '" + dstart.to_s + "'")
			c << ("travel_times.to_date < '" + dend.to_s + "'")
		end

		if max_price.to_i > 0
			price = max_price.to_s
			c << ("travel_times.price <= #{price}")
		end

		conditions = c.join(" AND ")

		c = TravelOffer.find(:all, :joins => [:travel_times, :destinations, :program_types], :select => "travel_offers.*", :group => "travel_offers.id", :conditions => conditions ).count

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :data => c.as_json}
			}
		end
	end

end