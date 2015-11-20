class CartItem
  include Mongoid::Document

	field :quantity, type: Integer, default: 1
  	belongs_to :cart
  	belongs_to :product

  	def total_price 
  		product.price * quantity
	end
  
end
