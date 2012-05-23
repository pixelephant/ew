class AjaxController < ApplicationController

	def get_region
		id = params[:id]
		r = Region.where(:country_id => id)

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :data => r.as_json}
			}
		end
	end

	def get_city
		id = params[:id]
		c = City.where(:region_id => id)

		respond_to do |format|
			format.json {
				render :json => {:error => "none", :data => c.as_json}
			}
		end
	end

end