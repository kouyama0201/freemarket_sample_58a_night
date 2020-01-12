FactoryBot.define do
  factory :user do
    name                  {"Taro"}
    email                 {"kkk@gmail.com"}
    initialize_with       { User.find_or_create_by(email: email)}
    password              {"00000000"}
    password_confirmation {"00000000"}
    lastname              {"山田"}
    firstname             {"太郎"}
    lastname_kana         {"ヤマダ"}
    firstname_kana        {"タロウ"}
    birth_year            {"1992"}
    birth_month           {"10"}
    birth_day             {"14"}
    phone                 {"0123456789"}
  end
end