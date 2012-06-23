class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_list_variables

  def set_list_variables

  	@order_by = 'travel_offers.created_at'
			
		params[:ord] == 'csokkeno' ? @ord = 'desc' : @ord = 'asc'

		case params[:sort]
			when 'legnepszerubbek' then @order_by = 'travel_offers.click'
			when 'legujabbak' then @order_by = 'travel_offers.created_at'
			when 'arnovekvo' then @order_by = 'travel_times.price'
			when 'arcsokkeno' then @order_by = 'travel_times.price'
			when 'utneve' then @order_by = 'travel_offers.travel_name'
		end

  	@program_types = ProgramType.all
		@price_checked = {'100000'.to_sym => false,'250000'.to_sym => false,'500000'.to_sym => false,'500001'.to_sym => false}
		@no_date_checked = false
		@regions = []
		@cities = []

		@travelofferscount = TravelOffer.find_by_sql("SELECT count(DISTINCT travel_offers.id) AS travel_offers_count FROM travel_offers INNER JOIN travel_times ON travel_times.travel_offer_id = travel_offers.id").first.travel_offers_count

		# t_countries = Destination.find_by_sql("SELECT destinations.country_id AS id, SUM(travel_offers.click) AS click FROM destinations INNER JOIN destinations_travel_offers ON destinations.id = destinations_travel_offers.destination_id INNER JOIN travel_offers ON travel_offers.id = destinations_travel_offers.travel_offer_id GROUP BY destinations.country_id ORDER BY SUM(travel_offers.click) LIMIT 4")
		# top_countries = t_countries.collect {|p| [p.id]}.join(",")
		top_countries = '51,81,82,150'
		@p_countries = Country.find_by_sql("SELECT * FROM countries WHERE id IN (#{top_countries})")

		@countries_europe = Country.find_by_sql("SELECT * FROM countries WHERE continent='europa' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_asia = Country.find_by_sql("SELECT * FROM countries WHERE continent='azsia' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_africa = Country.find_by_sql("SELECT * FROM countries WHERE continent='afrika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_namerica = Country.find_by_sql("SELECT * FROM countries WHERE continent='eszakamerika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_samerica = Country.find_by_sql("SELECT * FROM countries WHERE continent='delamerika' AND id NOT IN (#{top_countries}) ORDER BY name")
		@countries_australia = Country.find_by_sql("SELECT * FROM countries WHERE continent='ausztralia' AND id NOT IN (#{top_countries}) ORDER BY name")
  end
end
