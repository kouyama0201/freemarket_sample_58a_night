class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  belongs_to :category
  belongs_to :size, optional: true

  validates :images, presence: true
  validates :name, length: { in: 1..40 }
  validates :description, length: { in: 1..1000 }
  validates :category_id, exclusion: { in: %w(---) }
  validates :size_id, exclusion: { in: %w(---) }, allow_nil: true
  validates :condition, exclusion: { in: %w(---) }
  validates :delivery_cost, exclusion: { in: %w(---) }
  validates :delivery_way, exclusion: { in: %w(---) }
  validates :delivery_origin, exclusion: { in: %w(---) }
  validates :preparatory_days, exclusion: { in: %w(---) }
  validates :price, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9999999 }
end
