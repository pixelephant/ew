namespace :clean do

  task :travel_data => :environment do
	 sql = <<-SQL
	 		DELETE FROM travel_times WHERE travel_times.to_date < NOW();
      DELETE travel_times.* FROM `travel_times` LEFT JOIN travel_offers ON travel_times.travel_offer_id = travel_offers.id WHERE travel_offers.id IS NULL;
    SQL
    # used to connect active record to the database
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection.execute(sql)
  end

 end