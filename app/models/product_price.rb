class ProductPrice
  include Mongoid::Document
  include Mongoid::Timestamps
  field :price_per_unit, type: Float
  field :unit, type: String
  field :category, type: String
  belongs_to :city
  belongs_to :product

  # validates :price_per_unit, :unit, presence: true
end
