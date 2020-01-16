FactoryBot.define do
  factory :user do
    name                  {"Taro"}
    sequence(:email)      {Faker::Internet.email}
    password              {"00000000"}
    password_confirmation {"00000000"}
    lastname              {"山田"}
    firstname             {"太郎"}
    lastname_kana         {"ヤマダ"}
    firstname_kana        {"タロウ"}
    birth_year            {"1992"}
    birth_month           {"10"}
    birth_day             {"14"}
    sequence(:phone)      {Faker::Number.leading_zero_number(digits: 11)}
  end
end