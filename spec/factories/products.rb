FactoryBot.define do
  factory :product do
    name             {"シャツ"}
    description      {"良い商品です"}
    condition        {"1"}
    delivery_cost    {"1"}
    delivery_way     {"未定"}
    delivery_origin  {"1"}
    preparatory_days {"1"}
    price            {"30000"}
    user
    association :category, factory: :category
    association :image, factory: :image
    after(:create) do |product|
      product.images << build(:image, product: product)
    end
  end
end
