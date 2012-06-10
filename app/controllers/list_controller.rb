# encoding: UTF-8
class ListController < ApplicationController
	layout "application"

	def index

		unless params[:filters].blank? && params[:sort].blank?
			@filt = params[:filters]
			@regions = Region.where(:country_id => @filt[:country]) unless @filt[:country].blank?
			@cities = City.where(:region_id => @filt[:region]) unless @filt[:region].blank?

			c = []

			#Filterek
			unless @filt.blank?
				if @filt[:no_date].to_i == 0
					if @filt[:flexibility].to_i > 0
						unless @filt[:arrival].blank?
							a = @filt[:arrival]
							t = Time.parse(a)
							tfrom = t - (@filt[:flexibility].to_i).days
							tto = t + (@filt[:flexibility].to_i).days
							c << "travel_times.from_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "'"
						end
						unless @filt[:departure].blank?
							a = @filt[:departure]
							t = Time.parse(a)
							tfrom = t - (@filt[:flexibility].to_i).days
							tto = t + (@filt[:flexibility].to_i).days
							c << "travel_times.to_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "'"
						end
					else
						(c << ('travel_times.from_date = ' + @filt[:arrival])) unless @filt[:arrival].blank?
						(c << ('travel_times.to_date = ' + @filt[:departure])) unless @filt[:departure].blank?
					end

					(c << ('destinations.city_id = ' + @filt[:city])) unless (@filt[:city].blank? || @filt[:city].to_i == 0)
					(c << ('destinations.region_id = ' + @filt[:region])) unless (@filt[:region].blank? || @filt[:region].to_i == 0)
					(c << ('destinations.country_id = ' + @filt[:country])) unless (@filt[:country].blank? || @filt[:country].to_i == 0)
				end
				if @filt[:no_date].to_i == 1
					@no_date_checked = true
					im = @filt[:imprecise].to_i
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

				p = []
				@filt[:program_type].each do |ptype|
					p << ptype
				end
				unless p.blank?
					prog_type = p.join(",")
				end
				c << ("program_types.id IN (#{prog_type})")

				if @filt[:price].to_i > 0
					price = @filt[:price].to_s
					@price_checked[price.to_sym] = true
					c << ("travel_times.price <= #{price}")
				end
			end
			#Filterek

		
		end

		conditions = ''
		conditions = c.join(" AND ") unless c.blank?

		traveloffers_array = TravelOffer.find(:all, :joins => [:travel_times, :destinations, :program_types], :select => "travel_offers.*", :order => @order_by + " " + @ord, :group => "travel_offers.id", :conditions => conditions )
		#@traveloffers = Kaminari.paginate_array(@traveloffers_array).page(params[:page])
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		
		render "index"
	end

	def naszutak
		traveloffers_array = TravelOffer.joins(:attributes).where(:attributes => {:id => 19})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h = "Nászutak"
		
		render "index"
	end

	def hajoutak
		traveloffers_array = TravelOffer.joins(:attributes).where(:attributes => {:id => 19})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Hajóutak"
		
		render "index"
	end

	def sieles
		traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => [7,19]})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Sielés"
		
		render "index"
	end

	def egzotikusutak
		traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 5}).order(@order_by)
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Egzotikus utak"

		render "index"
	end

	def korutazasok
		traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => [6,8]})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Körutazások"
		
		render "index"
	end

	def varoslatogatasok
		traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 2})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Városlátogatások"
		
		render "index"
	end

	def sportutak
		traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 23})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Sportutak"
		
		render "index"
	end

	def kulfoldiutazasok
		traveloffers_array = TravelOffer.joins(:destinations).where('destinations.country_id <> 132')
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Külföldi utazások"
		
		render "index"
	end

	def belfoldiutazasok
		traveloffers_array = TravelOffer.joins(:destinations).where(:destinations => {:country_id => 132})
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Belföldi utazások"
		
		render "index"
	end

	def kereses
		word = params[:query]

		traveloffers_array = TravelOffer.joins(:descriptions).where("descriptions.description LIKE '%#{word}%' OR travel_offers.travel_name  LIKE '%#{word}%' OR travel_offers.szallas_name LIKE '%#{word}%'")
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = "Keresés: #{word}"
		
		render "index"
	end

end