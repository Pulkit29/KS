class Api::V1::CitiesController < ApplicationController

	def create
		@city = City.find_by(:city_name => params[:city][:city_name]) rescue nil
		if !@city
			@city = City.create! (city_params) rescue nil
		end
		respond_to do |format|
	      	format.html { redirect_to api_v1_cities_url }
	    end
	end

	def index
		@cities = City.all
	end

	def new
	end

	def destroy
		@city = City.find(params[:id])
		@city.destroy!
		respond_to do |format|
	      	format.html { redirect_to api_v1_cities_url }
	    end
	end

	private

	def city_params
		params.require(:city).permit(:city_name)
	end
end
