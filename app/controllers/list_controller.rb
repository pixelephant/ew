class ListController < ApplicationController
	layout "application"

	def index

		@filt = params[:filters]
		@program_types = ProgramType.all
		@regions = Region.where(:country_id => @filt[:country]) unless @filt[:country].blank?
		@cities = City.where(:region_id => @filt[:region]) unless @filt[:region].blank?

		order_by = 'travel_offers.created_at'

		params[:ord] == 'csokkeno' ? ord = 'desc' : ord = 'asc'

		case params[:sort]
			when 'legnepszerubbek' then order_by = 'travel_times.click'
			when 'legujabbak' then order_by = 'travel_offers.created_at'
			when 'arnovekvo' then order_by = 'travel_times.price'
			when 'arcsokkeno' then order_by = 'travel_times.price'
			when 'utneve' then order_by = 'travel_offers.travel_name'
		end

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
				im = @filt[:imprecise].to_i
				if im > 1 && im < 13
					if Date.today.month.to_i < im
						d = (Date.today.year.to_i + 1).to_s + "-" + Date.today.month.to_s
					else
						d = Date.today.year.to_s + "-" + Date.today.month.to_s
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
		end
		#Filterek

		conditions = c.join(" AND ")

		traveloffers_array = TravelOffer.find(:all, :joins => [:travel_times, :destinations, :program_types], :select => "travel_offers.*", :order => order_by + " " + ord, :group => "travel_offers.id", :conditions => conditions )
		#@traveloffers = Kaminari.paginate_array(@traveloffers_array).page(params[:page])
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		render "index"
	end

end
