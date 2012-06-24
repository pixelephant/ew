# encoding: UTF-8
class ListController < ApplicationController
	layout "application"

	def index

		c = []

		@h2 = "Utazási ajánlataink"
		@title = "Utazási ajánlataink"
		@description = "Utazási ajánlataink"

		case params[:travel_type]
			when 'naszutak'
				c << "(travel_attributes.id = 1)"
				@h2 = "Nászutak"
				@img = "/assets/category_headers/naszutak.jpg"
				@text = "Esküvő letudva? Irány pihenni! Az East-West nászút ajánlataival a közös élet kezdete igazán pihentető lesz."
				@title = @h2
				@description = @text
			when 'hajoutak'
				c << "(travel_attributes.id = 19)"
				@h2 = "Hajóutak"
				@img = "/assets/category_headers/hajo.jpg"
				@text = "Különleges hajóutak, luxus óceánjárók. Szervezze meg tengeri élményeit az East-West-nél!"
				@title = @h2
				@description = @text
			when 'sieles'
				c << "(program_types.id IN (7,19))"
				@h2 = "Sielés"
				@img = "/assets/category_headers/sieles.jpg"
				@text = "Síutak, snowboard utak és sítúrák; az East-West pénztárcabarát utakat kínál a legtöbb európai síparadicsomba."
				@title = @h2
				@description = @text
			when 'egzotikusutak'
				c << "(program_types.id = 5)"
				@h2 = "Egzotikus utak"
				@img = "/assets/category_headers/egzotikus.jpg"
				@text = "Tegye feledhetetlenné pihenését egy egzotikus nyaralással. Az East-West az év minden időszakában elérhetővé teszi a legszebb egzotikus utakat."
				@title = @h2
				@description = @text
			when 'korutazasok'
				c << "(program_types.id IN (6,8))"
				@h2 = "Körutazások"
				@img = "/assets/category_headers/korut.jpg"
				@text = "Az East-West körutazásai olyan turistáknak, akik, ha már kimozdulnak nem elégszenek meg egy kultúra megismerésével."
				@title = @h2
				@description = @text
			when 'varoslatogatasok'
				c << "(program_types.id = 2)"
				@h2 = "Városlátogatások"
				@img = "/assets/category_headers/varos.jpg"
				@text = "Elege van a tengerpartokból? Az aktív üdülés híve? Az East-West városlátogatásai a népszerű célpontok mellett a kevésbé zsúfolt városokat is elérhetővé teszik."
				@title = @h2
				@description = @text
			when 'sportutak'
				c << "(program_types.id = 23)"
				@h2 = "Sportutak"
				@img = "/assets/category_headers/sport.jpg"
				@text = "Football meccsek és egyéb sportesemények a világ minden tájáról. Egyedi ajánlatok az igazán aktívan pihenőknek-"
				@title = @h2
				@description = @text
			when 'kulfoldiutazasok'
				c << "(destinations.country_id <> 132)"
				@h2 = "Külföldi utazások"
				@img = "/assets/category_headers/kulfold.jpg"
				@text = "Fedezze fel a világ csodálatos helyeit. Az East-West külföldi utazásaival eljuthat a világ midnen pontjára."
				@title = @h2
				@description = @text
			when 'belfoldiutazasok'
				c << "(destinations.country_id = 132)"
				@h2 = "Belföldi utazások"
				@img = "/assets/category_headers/belfold.jpg"
				@text = "Magyarország csodálatos hely. Belföldi utazásainkkal felfedezheti Magyarország tájait, gyönyörű üdülőhelyeit."
				@title = @h2
				@description = @text
			when 'akciosutak'
				c << "(travel_times.discount = 1)"
				@h2 = "Akciós utak"
				@img = "/assets/category_headers/akcios.jpg"
				@text = "Az East-West pénztárcabarát utazásai. Akciós útjaink naponta frissülnek így érdemes gyakran rájuk pillantani."
				@title = @h2
				@description = @text
			when 'lastminute'
				from = (Time.now + 1.day).to_date
				to = (Time.now + 14.days).to_date
				c << "(travel_times.from_date BETWEEN '#{from}' AND '#{to}')"
				@h2 = "Last-minute utazások"
				@img = "/assets/category_headers/lastminute.jpg"
				@text = "Last minute utazások a gyors csomagolóknak. Az East-West legjobb külföldi és belföldi last minute utazásai egy helyen."
				@title = @h2
				@description = @text
		end		

		@filt = params[:filters]
		@filt = params[:search] if params[:search]

		unless @filt.blank? && params[:sort].blank?

			#Filterek
			unless @filt.blank?
				@regions = Region.where(:country_id => @filt[:country]) unless @filt[:country].blank?
				@cities = City.where(:region_id => @filt[:region]) unless @filt[:region].blank?

				if @filt[:no_date]
					if @filt[:no_date].to_i == 0
						if @filt[:flexibility].to_i > 0
							unless @filt[:arrival].blank?
								a = @filt[:arrival]
								t = Time.parse(a)
								tfrom = t - (@filt[:flexibility].to_i).days
								tto = t + (@filt[:flexibility].to_i).days
								c << "((travel_times.from_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "') OR (DATEDIFF(travel_times.to_date,travel_times.from_date) > night+2))"
							end
							unless @filt[:departure].blank?
								a = @filt[:departure]
								t = Time.parse(a)
								tfrom = t - (@filt[:flexibility].to_i).days
								tto = t + (@filt[:flexibility].to_i).days
								c << "((travel_times.to_date BETWEEN '" + tfrom.to_s + "' AND '" + tto.to_s + "') OR (DATEDIFF(travel_times.to_date,travel_times.from_date) > night+2))"
							end
							session[:from] = tfrom
							session[:to] = tto
						else
							(c << ('travel_times.from_date = ' + @filt[:arrival])) unless @filt[:arrival].blank?
							(c << ('travel_times.to_date = ' + @filt[:departure])) unless @filt[:departure].blank?
							session[:from] = @filt[:arrival]
							session[:to] = @filt[:departure]
						end
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
						session[:from] = dstart
						session[:to] = dend
					end
				end

				(c << ('destinations.city_id = ' + @filt[:city])) unless (@filt[:city].blank? || @filt[:city].to_i == 0)
				(c << ('destinations.region_id = ' + @filt[:region])) unless (@filt[:region].blank? || @filt[:region].to_i == 0)
				(c << ('destinations.country_id = ' + @filt[:country])) unless (@filt[:country].blank? || @filt[:country].to_i == 0)

				# p = []
				# @filt[:program_type].each do |ptype|
				# 	p << ptype
				# end
				# unless p.blank?
				# 	prog_type = p.join(",")
				# end
				# c << ("program_types.id IN (#{prog_type})")

				unless @filt[:price].blank?
					price = @filt[:price].to_s
					p = price.split("-")

					if p[1]
						@price_checked[p[1].to_sym] = true
						p_eur = []
						p_eur[0] = p[0].to_i / EURHUF
						p_eur[1] = p[1].to_i / EURHUF
						c << ("((travel_times.price BETWEEN #{p[0]} AND #{p[1]} AND price_measure IN ('Ft/fő','Ft/szoba')) OR (travel_times.price BETWEEN #{p_eur[0]} AND #{p_eur[1]} AND price_measure IN ('EUR/fő','EUR/szoba')))")
					else
						@price_checked[p[0].to_sym] = true
						p_eur = p[0].to_i / EURHUF
						c << ("((travel_times.price > #{p[0]} AND price_measure IN ('Ft/fő','Ft/szoba')) OR (travel_times.price > #{p_eur} AND price_measure IN ('EUR/fő','EUR/szoba')))")
					end
				end
			end
			#Filterek
		
		end

		conditions = ''
		conditions = c.join(" AND ") unless c.blank?

		traveloffers_array = TravelOffer.find(:all, :joins => [:travel_times, :destinations, :program_types, :travel_attributes], :select => "DISTINCT travel_offers.*", :order => @order_by + " " + @ord, :group => "travel_offers.id", :conditions => conditions )
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		# @traveloffers = traveloffers_array.page(params[:page])
		
		render "index"
	end

	def naszutak
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:travel_attributes).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:travel_attributes => {:id => 19}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:travel_attributes).where(:travel_attributes => {:id => 1}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Nászutak"
		@img = "/assets/category_headers/naszutak.jpg"
		@text = "Esküvő letudva? Irány pihenni! Az East-West nászút ajánlataival a közös élet kezdete igazán pihentető lesz."
		render "index"
	end

	def hajoutak
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array= TravelOffer.joins(:travel_attributes).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:travel_attributes => {:id => 19}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:travel_attributes).where(:travel_attributes => {:id => 19}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Hajóutak"
		@img = "/assets/category_headers/hajo.jpg"
		@text = "Különleges hajóutak, luxus óceánjárók. Szervezze meg tengeri élményeit az East-West-nél!"
		render "index"
	end

	def sieles
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array= TravelOffer.joins(:program_types).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:program_types => {:id => [7,19]}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => [7,19]}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Sielés"
		@img = "/assets/category_headers/sieles.jpg"
		@text = "Síutak, snowboard utak és sítúrák; az East-West pénztárcabarát utakat kínál a legtöbb európai síparadicsomba."
		render "index"
	end

	def egzotikusutak
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:program_types).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:program_types => {:id => 5}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 5}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Egzotikus utak"
		@img = "/assets/category_headers/egzotikus.jpg"
		@text = "Tegye feledhetetlenné pihenését egy egzotikus nyaralással. Az East-West az év minden időszakában elérhetővé teszi a legszebb egzotikus utakat."
		render "index"
	end

	def korutazasok
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:program_types).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:program_types => {:id => [6,8]}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => [6,8]}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Körutazások"
		@img = "/assets/category_headers/korut.jpg"
		@text = "Az East-West körutazásai olyan turistáknak, akik, ha már kimozdulnak nem elégszenek meg egy kultúra megismerésével."
		render "index"
	end

	def varoslatogatasok
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array= TravelOffer.joins(:program_types).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:program_types => {:id => 2}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 2}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Városlátogatások"
		@img = "/assets/category_headers/varos.jpg"
		@text = "Elege van a tengerpartokból? Az aktív üdülés híve? Az East-West városlátogatásai a népszerű célpontok mellett a kevésbé zsúfolt városokat is elérhetővé teszik."
		render "index"
	end

	def sportutak
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:program_types).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:program_types => {:id => 23}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:program_types).where(:program_types => {:id => 23}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Sportutak"
		@img = "/assets/category_headers/sport.jpg"
		@text = "Football meccsek és egyéb sportesemények a világ minden tájáról. Egyedi ajánlatok az igazán aktívan pihenőknek-"
		render "index"
	end

	def kulfoldiutazasok
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins([:destinations,:travel_times]).select("DISTINCT travel_offers.*").group("travel_offers.id").where('destinations.country_id <> 132').order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:destinations).where('destinations.country_id <> 132').order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Külföldi utazások"
		@img = "/assets/category_headers/kulfold.jpg"
		@text = "Fedezze fel a világ csodálatos helyeit. Az East-West külföldi utazásaival eljuthat a világ midnen pontjára."
		render "index"
	end

	def belfoldiutazasok
		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:destinations).joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where(:destinations => {:country_id => 132}).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.joins(:destinations).where(:destinations => {:country_id => 132}).order(@order_by + " " + @ord)
		end
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Belföldi utazások"
		@img = "/assets/category_headers/belfold.jpg"
		@text = "Magyarország csodálatos hely. Belföldi utazásainkkal felfedezheti Magyarország tájait, gyönyörű üdülőhelyeit."
		render "index"
	end

	def akciosutak
		travel_times = TravelTime.find_by_sql("SELECT DISTINCT travel_offer_id FROM travel_times WHERE discount=1")
		tt_id = []
		travel_times.each do |tt|
			tt_id << tt.travel_offer_id
		end

		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.joins(:travel_times).select("travel_offers.*").group("travel_offers.id").where(:id => tt_id).order(@order_by + " " + @ord)
		else
			traveloffers_array = TravelOffer.where(:id => tt_id).order(@order_by + " " + @ord)
		end
		#@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Akciós utak"
		@img = "/assets/category_headers/akcios.jpg"
		@text = "Az East-West pénztárcabarát utazásai. Akciós útjaink naponta frissülnek így érdemes gyakran rájuk pillantani."
		render "index"
	end

	def lastminute
		from = (Time.now + 1.day).to_date
		to = (Time.now + 14.days).to_date

		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
		end

		traveloffers_array = TravelOffer.joins(:travel_times).select("DISTINCT travel_offers.*").group("travel_offers.id").where("travel_times.from_date BETWEEN '#{from}' AND '#{to}'").order(@order_by + " " + @ord)
		# @traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@traveloffers = traveloffers_array.page(params[:page])
		@h2 = "Last-minute utazások"
		@img = "/assets/category_headers/lastminute.jpg"
		@text = "Last minute utazások a gyors csomagolóknak. Az East-West legjobb külföldi és belföldi last minute utazásai egy helyen."
		render "index"
	end

	def kereses
		word = params[:query]

		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.find(:all, :group => "travel_offers.id", :select => "DISTINCT travel_offers.*",:joins => [:descriptions, :travel_times], :order => @order_by + " " + @ord, :conditions => "descriptions.description LIKE '%#{word}%' OR travel_offers.travel_name LIKE '%#{word}%' OR travel_offers.szallas_name LIKE '%#{word}%'")
		else
			traveloffers_array = TravelOffer.find(:all, :select => "DISTINCT travel_offers.*",:joins => :descriptions, :order => @order_by + " " + @ord, :conditions => "descriptions.description LIKE '%#{word}%' OR travel_offers.travel_name LIKE '%#{word}%' OR travel_offers.szallas_name LIKE '%#{word}%'")
		end
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		# @traveloffers = traveloffers_array.page(params[:page])
		@h2 = "#{word}"

		@title = "Utazások az alábbi kifejezésre: " + @h2
		@description = "Keresési találatok az alábbi kifejezésre: " + @h2
		
		render "index"
	end

	def uticelok
		country = Country.where(:slug => params[:country_name].to_s).first

		if @order_by == 'travel_times.price'
			@order_by = 'MIN(travel_times.price)'
			traveloffers_array = TravelOffer.find(:all, :group => "travel_offers.id" ,:select => "DISTINCT travel_offers.*",:joins => [:destinations, :travel_times], :order => @order_by + " " + @ord, :conditions => "destinations.country_id = #{country.id}")
		else
			traveloffers_array = TravelOffer.find(:all, :select => "DISTINCT travel_offers.*",:joins => :destinations, :order => @order_by + " " + @ord, :conditions => "destinations.country_id = #{country.id}")
		end
		# @traveloffers = traveloffers_array.page(params[:page])
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		@h2 = country.name

		@title = "Uticél: " + @h2
		@description = "Az utazás célja: " + @h2

		render "index"
	end

end