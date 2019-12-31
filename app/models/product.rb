class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  belongs_to :size, optional: true

  enum delivery_cost: {
    "---":0, 送料込み（出品者負担）:1, 着払い（購入者負担）:2
  }
end
