class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, inverse_of: :address

  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/
  VALID_PHONE_REGEX = /\A0\d{9,10}\z/

  validates :postal_code,     presence: true, format: { with: VALID_POSTAL_CODE_REGEX}
  validates :prefecture_id,   presence: true
  validates :city,            presence: true
  validates :street,          presence: true
  validates :phone_optional,  allow_blank: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }

end
