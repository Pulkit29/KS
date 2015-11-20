class Api::V1::CartItemsController < ApplicationController
	include CurrentCart
	# before_action :set_cart, only: [:create]
	# before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

	def create
		product = Product.find(params[:product_id])
		@cart = Cart.set_cart params[:cart_id]
		# @cart_item = @cart.cart_items.build(product: product)
		@cart_item = @cart.cart_items.add_product(product.id)
		respond_to do |format|
			if @cart_item.save
				# format.html { redirect_to @line_item.cart,
				# notice: 'Line item was successfully created.' }
				# format.json { render action: 'show',
				# status: :created, location: @cart_item }
				format.json {
					render json: @cart_item
				}
			else
				# format.html { render action: 'new' }
				format.json { render json: @cart_item.errors,
				status: :unprocessable_entity }
			end
		end
	end
end
