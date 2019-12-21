class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :category
  belongs_to :brand
end
