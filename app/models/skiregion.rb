class Skiregion < ActiveRecord::Base
  belongs_to :country
  belongs_to :region
  has_many :travel_offers

  attr_accessible :name, :region_id, :country_id
end
