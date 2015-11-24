module CurrentCart
	extend ActiveSupport::Concern
	private
		def set_cart (cart_id)
			if cart_id && cart_id != ''
				cart = Cart.find(cart_id)
				# rescue ActiveRecord::RecordNotFound
				cart = Cart.create
			else
				cart = Cart.create
			end
			return cart
		end
end