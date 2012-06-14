class Good < ActiveRecord::Base
  belongs_to :country

  attr_accessible :content, :country_id
end
