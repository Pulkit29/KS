class Api::V1::ProductsController < ApplicationController
	def create
		@category = Category.find(params[:product][:category_id])
		if @category
			@product = Product.find_by(:p_name => params[:product][:p_name]) rescue nil
			if !@product
				@product = @category.products.build
				@product.p_name = params[:product][:p_name]
				@product.save!
			end
			price = @product.product_prices.build
			price.price_per_unit = params[:product][:product_price][:price]
			price.unit = params[:product][:product_price][:unit]
			price.category = @category.category_name
			price.city_id = params[:product][:city_id]

			if @product.save! && price.save!
				redirect_to :controller => 'product_prices', :action => 'index'
			end
		end
	end

	def index
		
	end

	def edit
		@product = Product.find(params[:prod_id])
		@categoryList = Category.all
		@city = City.all
		# @product_price = ProductPrice.find(params[:id])
		# @product = @product_price.product
	end

	def new
		@categoryList = Category.all
		@city = City.all
	end
end
