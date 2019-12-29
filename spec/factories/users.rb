FactoryBot.define do
  
  factory :user do
    name                  {"Taro"}
    email                 {"kkk@gmail.com"}
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
    # factory :address do
    #     postal_code             {"1234567"}
    #     prefecture_id           {"1"}
    #     city                    {"名古屋市"}
    #     street                  {"港区1-2-3"}
    #     phone_optional          {"0123456789"}
    # end
  end
end