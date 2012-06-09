class PreBooking < ActiveRecord::Base
	belongs_to :travel_time

	attr_accessible :id, :travel_time_id, :start_date, :end_date, :type, :amount, :description
end
