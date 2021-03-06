class Api::V1::CategoriesController < ApplicationController

	def create
		@category
		if params[:product_category][:parent_category_id].length > 0
			@parent = Category.find(params[:product_category][:parent_category_id]) rescue nil
			if @parent
				@category = @parent.child_categories.create!(category_params)
			end
		else
			@category = Category.find(params[:product_category][:category_name]) rescue nil
			if !@category
				@category = Category.create!(category_params)
			end
		end
		
		respond_to do |format|
	      	# format.json { render json: {:success => true, :menu_category => @category, :message => 'MenuCategory successfully created' }}
	      	format.html { redirect_to new_api_v1_product_url }
	    end
	end

	def new
		@parentList = Category.all
	end

	def index
		@categories = Category.all
		@categoryList = Category.where(:parent_category_id => nil)
		respond_to do |format|
			format.json{
				render :json => {
					:success => true,
					:categories => @categoryList,
				}
			}

			format.html
		end
	end

	def show
		
	end

	def getChildCategoriesOrProducts
		@parent_category = Category.find(params[:categoryid]) rescue nil
		@items = []
		@item_price = []
		if @parent_category
			@category = Category.where(:parent_category_id => params[:categoryid])
			city = City.find_by(:city_name => params[:city].upcase!) rescue nil
			if @category.count > 0
				i = 0
				@category.count.times do
					@prod_prices = []
					@prods = @category[i].products
					j = 0
					@category[i].products.count.times do
						prod = @category[i].products[j]
						prod_price = ProductPrice.where(:product_id => prod.id, :city_id => city.id)
						if prod_price.count <= 0
							@prods = @prods - prod.to_a
						else
							@prod_prices << prod_price[0]
						end
						j += 1
					end
					@items << @prods
					@item_price << @prod_prices
					i += 1
				end
			else
				byebug
				@prods = @parent_category.products
				@prod_prices = []
				j = 0
				@parent_category.products.count.times do
					prod = @parent_category.products[j]
					prod_price = ProductPrice.where(:product_id => prod.id, :city_id => city.id)
					if prod_price.count <= 0
						byebug
						@prods = @prods - prod.to_a
					else
						@prod_prices << prod_price[0]
					end
					
					j += 1
				end
				@items = @prods
				@item_price = @prod_prices

				# if @item_price.count < @items.count
				# 	k =0
				# 	@items.count.times do 
				# 		item = @items[k]
				# 		if @item_price.include?(item)
				# 		end
				# 	end
				# end
			end
		end

		render :json => {
			:success => true,
			:childcategories => @category,
			:items => @items,
			:item_prices => @item_price
		}
	end

	def destroy
		@category = Category.find(params[:id]) rescue nil
		if @category
			@category.destroy!
		end
		respond_to do |format|
	      	# format.json { render json: {:success => true, :menu_category => @category, :message => 'MenuCategory successfully created' }}
	      	format.html { redirect_to api_v1_categories_url }
	    end

	end

	private

	def category_params
		params.require(:product_category).permit(:category_name)
	end
end
