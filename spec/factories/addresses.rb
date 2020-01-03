FactoryBot.define do
  factory :address  do
        postal_code             {"123-4567"}
        prefecture_id           {"1"}
        city                    {"名古屋市"}
        street                  {"港区1-2-3"}
        phone_optional          {"0123456789"}
        association :user, factory: :user
  end
end