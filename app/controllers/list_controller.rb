class ListController < ApplicationController
	layout "application"

	def index

		@program_types = ProgramType.all
		c = []
		ord = 'desc'
		@price_checked = {'50000'.to_sym => false,'150000'.to_sym => false,'250000'.to_sym => false,'550000'.to_sym => false}
		@no_date_checked = false
		@regions = []
		@cities = []

		@travelofferscount = TravelOffer.find_by_sql("SELECT count(DISTINCT travel_offers.id) AS travel_offers_count FROM travel_offers INNER JOIN travel_times ON travel_times.travel_offer_id = travel_offers.id").first.travel_offers_count

		@p_countries = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(DISTINCT travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` GROUP BY destinations.country_id ORDER BY travel_times.click desc LIMIT 4")
		top_countries = @p_countries.collect {|p| [p.id]}.join(",")

		@countries_europe = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='europa' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")
		@countries_asia = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='azsia' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")
		@countries_africa = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='afrika' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")
		@countries_namerica = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='eszakamerika' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")
		@countries_samerica = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='delamerika' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")
		@countries_australia = Destination.find_by_sql("SELECT countries.name, countries.id AS id, count(travel_offers.id) AS travel_offers_count, sum(travel_times.click) AS click FROM `travel_offers` INNER JOIN `destinations_travel_offers` ON `destinations_travel_offers`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `destinations` ON `destinations`.`id` = `destinations_travel_offers`.`destination_id` INNER JOIN `travel_times` ON `travel_times`.`travel_offer_id` = `travel_offers`.`id` INNER JOIN `countries` ON `countries`.`id` = `destinations`.`country_id` WHERE continent='ausztralia' AND countries.id NOT IN (#{top_countries}) GROUP BY destinations.country_id ORDER BY travel_times.click desc")


		unless params[:filters].blank? && params[:sort].blank?
			@filt = params[:filters]
			@regions = Region.where(:country_id => @filt[:country]) unless @filt[:country].blank?
			@cities = City.where(:region_id => @filt[:region]) unless @filt[:region].blank?
			
			params[:ord] == 'csokkeno' ? ord = 'desc' : ord = 'asc'

			case params[:sort]
				when 'legnepszerubbek' then order_by = 'travel_times.click'
				when 'legujabbak' then order_by = 'travel_offers.created_at'
				when 'arnovekvo' then order_by = 'travel_times.price'
				when 'arcsokkeno' then order_by = 'travel_times.price'
				when 'utneve' then order_by = 'travel_offers.travel_name'
			end

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

		conditions = c.join(" AND ")

		order_by = 'travel_offers.created_at'

		traveloffers_array = TravelOffer.find(:all, :joins => [:travel_times, :destinations, :program_types], :select => "travel_offers.*", :order => order_by + " " + ord, :group => "travel_offers.id", :conditions => conditions )
		#@traveloffers = Kaminari.paginate_array(@traveloffers_array).page(params[:page])
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		render "index"
	end

end
