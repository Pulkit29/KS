class Category
  include Mongoid::Document

  field :category_name, type: String
  has_many :products, dependent: :destroy

  has_many :child_categories, class_name: "Category", foreign_key: "parent_category_id", dependent: :destroy
  belongs_to :parent_category, class_name: "Category"

end
