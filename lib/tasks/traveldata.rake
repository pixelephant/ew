namespace :setup do

	require 'nokogiri'
	require 'open-uri'

	include ActionView::Helpers::SanitizeHelper
  
  task :torzsadat => :environment do

  	desc "Processing xml file containing setup data"
    # get file
    puts "Processing file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmltorzsekgen.xml"))

		doc.css("traffics traffic").each_with_index do |traffic, i|
			id = traffic.attribute("id").to_s
			unless Traffic.find(id).any?
				Traffic.new(:id => id, :name => traffic.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		doc.css("program_types program_type").each_with_index do |ptype, i|
			id = ptype.attribute("id").to_s
			unless ProgramType.find(id).any?
				ProgramType.new(:id => id, :name => ptype.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		doc.css("boards board").each_with_index do |board, i|
			id = board.attribute("id").to_s
			unless Board.find(id).any?
				Board.new(:id => id, :name => board.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		doc.css("attributes attribute").each_with_index do |attrib, i|
			id = attrib.attribute("id").to_s
			unless Attribute.find(id).any?
				Attribute.new(:id => id, :name => attrib.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		doc.css("unnepek unnep").each_with_index do |hday, i|
			id = hday.attribute("id").to_s
			unless Holiday.find(id).any?
				Holiday.new(:id => id, :name => hday.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		doc.css("inoutprices inoutprice").each_with_index do |ioprice, i|
			id = ioprice.attribute("id").to_s
			unless Inprice.find(id).any?
				Inprice.new(:id => id, :name => ioprice.css("name").inner_text).save!
			end
			unless Outprice.find(id).any?
				Outprice.new(:id => id, :name => ioprice.css("name").inner_text).save!
			end
		end
		a_count += ((i+1)*2)

		doc.css("traveldays travelday").each_with_index do |tday, i|
			id = tday.attribute("id").to_s
			unless Travelday.find(id).any?
				Travelday.new(:id => id, :name => tday.css("name").inner_text).save!
			end
		end
		a_count += (i+1)

		puts "Attributes processed: " + a_count

  end
		
	task :destinations => :environment do

		desc "Processing xml file containing country data"
    # get file
    puts "Processing file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlorszaggen.xml"))

		doc.css("countries country").each_with_index do |country, i|
			id = country.attribute("id").to_s
			unless Country.find(id).any?
				Country.new(:id => id, :name => country.css("name").inner_text).save!
			end
		end
		
		puts "Countries processed: " + (i+1).to_s

		#Region
    # get file
    puts "Processing region file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlregiogen.xml"))

		doc.css("regions region").each_with_index do |region, i|
			id = region.attribute("id").to_s
			unless Region.find(id).any?
				Region.new(:id => id, :country_id => region.attribute("country_id").to_s , :name => region.css("name").inner_text).save!
			end
		end
		puts "Countries processed: " + (i+1).to_s

		#City
		# get file
    puts "Processing region file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlvarosgen.xml"))

		doc.css("cities city").each_with_index do |city, i|
			id = city.attribute("id").to_s
			unless City.find(id).any?
				#Ide kell a google cucc
				c = City.new(:id => id, :country_id => city.attribute("country_id").to_s, :city_id => city.attribute("region_id").to_s, :name => city.css("name").inner_text).save!
				address = c.city.name + "," + c.country.name
				coord = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")
				j = ""
				coord.each do |l|
					j << l
				end
				lat = j["results"[0]]["geometry"]["location"]["lat"]
				long = j["results"[0]]["geometry"]["location"]["lng"]
				c.lat = lat
				c.long = long
				c.save!
			end
		end
		puts "Cities processed: " + (i+1).to_s
	
	end

	task :partners => :environment do
		desc "Processing xml file containing partner data"
    # get file
    puts "Processing file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlpartnergen.xml"))

		doc.css("partners partner").each_with_index do |partner, i|
			id = partner.css("id").inner_text
			p = Partner.find_or_create_by_id(id)

			p.name = partner.css("name").inner_text
			p.email = partner.css("email").inner_text
			p.contact = partner.css("kapcsolattarto").inner_text
			p.offers = partner.css("ajanlatok").inner_text
			p.info = partner.css("tajekoztato").inner_text
			p.save!
		end
		
		puts "Partners processed: " + (i+1).to_s
	end

	

end
