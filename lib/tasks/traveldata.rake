namespace :setup do

	require 'nokogiri'
	require 'open-uri'
	require 'erb'

	include ERB::Util
	include ActionView::Helpers::SanitizeHelper
  
  task :torzsadat => :environment do

  	desc "Processing xml file containing setup data"
    # get file
    puts "Processing file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmltorzsekgen.xml"))

		doc.css("traffics traffic").each_with_index do |traffic, i|
			puts "Traffic: " + traffic.to_s
			id = traffic.attribute("id").to_s
			unless Traffic.exists?(id)
				Traffic.new(:id => id, :name => traffic.css("name").inner_text).save!
			end
			a_count += 1
		end
		

		doc.css("program_types program_type").each_with_index do |ptype, i|
			puts "Traffic: " + ptype.to_s
			id = ptype.attribute("id").to_s
			unless ProgramType.exists?(id)
				ProgramType.new(:id => id, :name => ptype.css("name").inner_text).save!
			end
			a_count += 1
		end

		doc.css("boards board").each_with_index do |board, i|
			puts "Traffic: " + board.to_s
			id = board.attribute("id").to_s
			unless Board.exists?(id)
				Board.new(:id => id, :name => board.css("name").inner_text).save!
			end
			a_count += 1
		end

		doc.css("attributes attribute").each_with_index do |attrib, i|
			puts "Traffic: " + attrib.to_s
			id = attrib.attribute("id").to_s
			unless Attribute.exists?(id)
				Attribute.new(:id => id, :name => attrib.css("name").inner_text).save!
			end
			a_count += 1
		end

		doc.css("unnepek unnep").each_with_index do |hday, i|
			puts "Traffic: " + hday.to_s
			id = hday.attribute("id").to_s
			unless Holiday.exists?(id)
				Holiday.new(:id => id, :name => hday.css("name").inner_text).save!
			end
			a_count += 1
		end

		doc.css("inoutprices inoutprice").each_with_index do |ioprice, i|
			puts "Traffic: " + ioprice.to_s
			id = ioprice.attribute("id").to_s
			unless Inprice.exists?(id)
				Inprice.new(:id => id, :name => ioprice.css("name").inner_text).save!
			end
			unless Outprice.exists?(id)
				Outprice.new(:id => id, :name => ioprice.css("name").inner_text).save!
			end
			a_count += 2
		end

		doc.css("traveldays travelday").each_with_index do |tday, i|
			puts "Traffic: " + tday.to_s
			id = tday.attribute("id").to_s
			unless Travelday.exists?(id)
				Travelday.new(:id => id, :name => tday.css("name").inner_text).save!
			end
			a_count += (i+1)
		end

		puts "Attributes processed: " + a_count.to_s

  end
		
	task :destinations => :environment do

		desc "Processing xml file containing country data"
    # get file
    puts "Processing file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlorszaggen.xml"))

		doc.css("countries country").each_with_index do |country, i|
			puts "Traffic: " + country.to_s
			id = country.attribute("id").to_s
			unless Country.exists?(id)
				Country.new(:id => id, :name => country.css("name").inner_text).save!
			end
			a_count = i
		end
		
		puts "Countries processed: " + a_count.to_s

		#Region
    # get file
    puts "Processing region file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlregiogen.xml"))

		doc.css("regions region").each_with_index do |region, i|
			id = region.attribute("id").to_s
			unless Region.exists?(id)
				Region.new(:id => id, :country_id => region.attribute("country_id").to_s , :name => region.css("name").inner_text).save!
			end
			a_count = i
		end
		puts "Regions processed: " + a_count.to_s

		#City
		# get file
    puts "Processing city file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlvarosgen.xml"))

		doc.css("cities city").each_with_index do |city, i|
			puts "Traffic: " + city.to_s
			id = city.attribute("id").to_s
			unless City.exists?(id)
				#Ide kell a google cucc
				c = City.new(:id => id, :country_id => city.attribute("country_id").to_s, :region_id => city.attribute("region_id").to_s, :name => city.css("name").inner_text).save!
				# c = City.find(id)
				# address = (c.name + " " + c.country.name).parameterize
				# coord = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")
				# puts coord.to_s
				# j = ""
				# coord.each do |l|
				# 	j << l
				# end
				# lat = j["results"][0]["geometry"]["location"]["lat"]
				# long = j["results"][0]["geometry"]["location"]["lng"]
				# c.lat = lat
				# c.long = long
				# c.save!
			end
			a_count = i
		end
		puts "Cities processed: " + a_count.to_s
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
			a_count = i
		end
		
		puts "Partners processed: " + a_count.to_s
	end

	task :skiregions => :environment do
		desc "Processing xml file containing skiregion data"
		#SkiRegion
    # get file
    puts "Processing skiregion file..."

    a_count = 0
		
		doc = Nokogiri::XML(File.open("public/xmlsiregiogen.xml"))

		doc.css("skiregions skiregion").each_with_index do |region, i|
			id = region.css("id").inner_text.to_s
			unless Skiregion.exists?(id)
				Skiregion.new(:id => id, :country_id => region.attribute("country_id").to_s , :name => region.css("name").inner_text, :region_id => region.attribute("region_id").to_s).save!
			end
			a_count = i
		end
		puts "Skiregions processed: " + a_count.to_s	
	end

	task :setgmap => :environment do

  	desc "Set lat & long values from city"
    # get file
		puts "Processing..."
		
		City.where(:lat => '', :long => '').each do |c|
			puts "City: " + c.to_s
			puts "City name: " + c.name.to_s + ", Country name: " + c.country.name.to_s
			address = (c.name + " " + c.country.name)
			puts "Address: " + address
			# coord = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")
			coord = open(URI.parse(URI.encode("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")))
			
			puts coord.to_s
			j = ""
			coord.each do |l|
				j << l.to_s
			end
			j = ActiveSupport::JSON.decode(j)
			puts j
			unless j["status"] == "ZERO_RESULTS"
				lat = j["results"][0]["geometry"]["location"]["lat"]
				long = j["results"][0]["geometry"]["location"]["lng"]
				puts "Lat: " + lat.to_s
				puts "Lng: " + long.to_s
				c.lat = lat
				c.long = long
				c.save!
			end
		end
		
  end

  task :all => :environment do
  	time = Time.now
  	Rake::Task['setup:torzsadat'].invoke()
  	Rake::Task['setup:destinations'].invoke()
  	Rake::Task['setup:partners'].invoke()
  	Rake::Task['setup:skiregions'].invoke()
  	puts ((Time.now - time) / 60).to_s
  end

end