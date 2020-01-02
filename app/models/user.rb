class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :products
  has_one :address, inverse_of: :user
  has_one :card
  has_many :sns_credentials
  accepts_nested_attributes_for :address

  # 正規表現用の定数
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}\z/i
  VALID_PHONE_REGEX = /\A0\d{9,10}\z/

  # バリデーション設定
  validates :name,                    presence: true
  validates :email,                   presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                confirmation: true, length: {minimum: 7, maximum: 128}, on: :create
  validates :password_confirmation,   length: {minimum: 7, maximum: 128}, on: :create
  validates :lastname,                presence: true
  validates :firstname,               presence: true
  validates :lastname_kana,           presence: true
  validates :firstname_kana,          presence: true
  validates :birth_year,              presence: true
  validates :birth_month,             presence: true
  validates :birth_day,               presence: true
  validates :phone,                   presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }

  def set_4digit_year
    year_4digit = []
    year_4digit << "--"
    year = 1940
    while (year < 2023) do
      year_4digit << year
      year += 1
    end
    return year_4digit
  end

  def set_birth_month
    birth_month = []
    birth_month << "--"
    month = 1
    while (month <= 12) do
      birth_month << month
      month += 1
    end
    return birth_month
  end

  def set_birth_day
    birth_day = []
    birth_day << "--"
    day = 1
    while (day <= 31) do
      birth_day << day
      day += 1
    end
    return birth_day
  end

end

