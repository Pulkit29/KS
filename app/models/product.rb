class Product
  include Mongoid::Document

  field :p_name, type: String
  field :p_desc, type: String
  field :image_url, type: String

  has_many :product_prices, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  belongs_to :category

  # validates :p_name, :p_desc, uniqueness: true, presence: true
  accepts_nested_attributes_for :product_prices

  def self.findbyName name
  	@product = self.find_by(:p_name => name)
	  rescue Mongoid::Errors::DocumentNotFound
	   @product = Product.new
		 @product.p_name = name
	  return @product
  end
end
