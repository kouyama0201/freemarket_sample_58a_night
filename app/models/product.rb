class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  belongs_to :category
  belongs_to :size, optional: true

  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: true
  validates :size_id, presence: true, allow_nil: true
  validates :condition, presence: true
  validates :delivery_cost, presence: true
  validates :delivery_way, presence: true
  validates :delivery_origin, presence: true
  validates :preparatory_days, presence: true
  validates :price, presence: true, 
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9999999 }
end
