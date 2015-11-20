class Cart
  include Mongoid::Document

  has_many :cart_items, dependent: :destroy

  	def add_product(product_id)
		current_item = cart_items.find_by(product_id: product_id) rescue nil
		if current_item
		    current_item.quantity += 1
		else
		    current_item = cart_items.build(product_id: product_id)
		end
		  current_item
	end

	def subtract_product(product_id)
		current_item = cart_items.find_by(product_id: product_id)  rescue nil
		if current_item
			if current_item.quantity == 1 
			    current_item.quantity = 0
			    current_item.destroy!
			else
				current_item.quantity -= 1
			end
		else
		    # current_item = cart_items.build(product_id: product_id)
		end
		  current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end
