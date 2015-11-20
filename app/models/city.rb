class City
  include Mongoid::Document

  field :city_name, type: String
  
  has_many :product_prices, dependent: :destroy

  # validates :city_name, presense: true, uniqueness: true

  def self.findByName name
  	@city = self.find_by(:city_name => name)
  	rescue Mongoid::Errors::DocumentNotFound
		@city = City.new
		@city.city_name = name
  	return @city
  end
end
