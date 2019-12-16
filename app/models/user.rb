class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  # devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_one :address, inverse_of: :user
  accepts_nested_attributes_for :address

  def set_4digit_year
    year_4digit = []
    year = 1940
    while (year < 2023) do
      year_4digit << year
      year += 1
    end
    return year_4digit
  end

  def set_birth_month
    birth_month = []
    month = 1
    while (month <= 12) do
      birth_month << month
      month += 1
    end
    return birth_month
  end

  def set_birth_day
    birth_day = []
    day = 1
    while (day <= 31) do
      birth_day << day
      day += 1
    end
    return birth_day
  end

  # def self.find_oauth(auth)
  #   uid = auth.uid
  #   provider = auth.provider
  #   snscredential = SnsCredential.where(uid: uid, provider: provider).first
  #   if snscredential.present?
  #     user = User.where(id: snscredential.user_id).first
  #   else
  #     user = User.where(email: auth.info.email).first
  #     if user.present?
  #       SnsCredential.create(
  #         uid: uid,
  #         provider: provider,
  #         user_id: user.id
  #         )
  #     else
  #       user = User.create(
  #         name: auth.info.name,
  #         email:    auth.info.email,
  #         password: Devise.friendly_token[0, 20],
  #         phone: "08000000000"
  #         )
  #       SnsCredential.create(
  #         uid: uid,
  #         provider: provider,
  #         user_id: user.id
  #         )
  #     end
  #   end
  #   return user
  # end
end

