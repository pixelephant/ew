class AjaxController < ApplicationController

	def get_region
		id = params[:id]
		r = Region.where(:country_id => id)
		c = City.where(:country_id => id)

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :region => r.as_json, :city => c.as_json}
			}
		end
	end

	def get_city
		id = params[:id]
		country_id = params[:country_id]

		if id.to_i > 0
			c = City.where(:region_id => id)
		else
			c = City.where(:country_id => country_id)
		end

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :data => c.as_json}
			}
		end
	end

end