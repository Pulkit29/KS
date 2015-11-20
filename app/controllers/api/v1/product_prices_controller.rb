class Api::V1::ProductPricesController < ApplicationController

	def index
		@product_price = ProductPrice.order(created_at: :desc)
	end

	def edit
		@product_price = ProductPrice.find(params[:id])
		# @categoryList = Category.all
		# @city = City.all
		# params[:id] = @product_price.product.id

		redirect_to :controller => 'products', :action => 'edit', :prod_id => @product_price.product.id 
		# render "/api/v1/products/#{@product_price.product.id}/edit"
		# render 'products/edit'
	end

	def destroy
		@product_price = ProductPrice.find(params[:id])
		@product_price.destroy!
		respond_to do |format|
	      	# format.json { render json: {:success => true, :menu_category => @category, :message => 'MenuCategory successfully created' }}
	      	format.html { redirect_to api_v1_product_prices_path }
	    end
	end
end
