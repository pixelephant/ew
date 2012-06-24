class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_list_variables

  def set_list_variables

  	@order_by = 'travel_offers.created_at'
			
		params[:ord] == 'csokkeno' ? @ord = 'desc' : @ord = 'asc'

		@legnepszerubbek = ''
		@legujabbak = ''
		@arnovekvo = ''
		@arcsokkeno = ''
		@utneve = ''

		case params[:sort]
			when 'legnepszerubbek'
				@order_by = 'travel_offers.click'
				@legnepszerubbek = ' active'
			when 'legujabbak'
				@order_by = 'travel_offers.created_at'
				@legujabbak = ' active'
			when 'arnovekvo'
				@order_by = 'travel_times.price'
				@arnovekvo = ' active'
			when 'arcsokkeno'
				@order_by = 'travel_times.price'
				@arcsokkeno = ' active'
			when 'utneve'
				@order_by = 'travel_offers.travel_name'
				@utneve = ' active'
		end

		@naszutak_menu = ''
		@sieles_menu = ''

		case request.fullpath.split("?")[0]
			when '/utjaink/naszutak'
				@naszutak_menu = 'active'
			when '/utjaink/sieles'
				@sieles_menu = 'active'
			when '/utjaink/lastminute'
				@lastminute_menu = 'active'
			when '/utjaink/kulfoldiutazasok'
				@kulfoldiutazasok_menu = 'active'
			when '/utjaink/akciosutak'
				@akciosutak_menu = 'active'
			when '/utjaink/hajoutak'
				@hajoutak_menu = 'active'
		end

  	# @program_types = ProgramType.all
		@price_checked = {'100000'.to_sym => false,'250000'.to_sym => false,'500000'.to_sym => false,'500001'.to_sym => false}
		@no_date_checked = false
		@regions = []
		@cities = []

		@travelofferscount = TravelOffer.find_by_sql("SELECT count(DISTINCT travel_offers.id) AS travel_offers_count FROM travel_offers INNER JOIN travel_times ON travel_times.travel_offer_id = travel_offers.id").first.travel_offers_count
		@sportut = (params[:travel_type] == 'sportutak' ? '1' : '0')

		# t_countries = Destination.find_by_sql("SELECT destinations.country_id AS id, SUM(travel_offers.click) AS click FROM destinations INNER JOIN destinations_travel_offers ON destinations.id = destinations_travel_offers.destination_id INNER JOIN travel_offers ON travel_offers.id = destinations_travel_offers.travel_offer_id GROUP BY destinations.country_id ORDER BY SUM(travel_offers.click) LIMIT 4")
		# top_countries = t_countries.collect {|p| [p.id]}.join(",")
		
		if params[:filters]
			filt = params[:filters]
			@selected_country = (filt[:country] ? filt[:country] : '')
			selected_country = @selected_country
		else
			selected_country = '150'
		end

		top_countries = '51,81,82,' + selected_country.to_s
		@p_countries = Country.find_by_sql("SELECT * FROM countries WHERE id IN (#{top_countries})")

		@countries_europe = Country.find_by_sql("SELECT * FROM countries WHERE continent='europa' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_asia = Country.find_by_sql("SELECT * FROM countries WHERE continent='azsia' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_africa = Country.find_by_sql("SELECT * FROM countries WHERE continent='afrika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_namerica = Country.find_by_sql("SELECT * FROM countries WHERE continent='eszakamerika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_samerica = Country.find_by_sql("SELECT * FROM countries WHERE continent='delamerika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_australia = Country.find_by_sql("SELECT * FROM countries WHERE continent='ausztralia' AND id NOT IN (#{top_countries}) ORDER BY name")
  end
end
