class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

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

    def set_2digit_year
    year_2digit = []
    year = 19
    while (year < 30 ) do
      year_2digit << year
      year += 1
    end
    return year_2digit
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

  def set_2digit_month
    year_2digit = ["01","02","03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    return year_2digit
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
end

