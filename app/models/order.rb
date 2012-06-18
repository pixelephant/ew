class Order < ActiveRecord::Base  
  belongs_to :travel_time

  attr_accessible :name, :email, :phone, :note, :adult, :children, :travel_time_id, :partner_name, :travel_text
end
