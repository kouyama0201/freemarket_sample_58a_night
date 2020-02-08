require 'rails_helper'
describe Product do
  describe '#create' do
    it "値が全て存在すれば登録できる" do
      category = create(:category)
      product = build(:product, category_id: category.id)
      expect(product).to be_valid
    end

    it "nameが空では登録できないこと" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "descriptionが空では登録できないこと" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "category_idが空では登録できないこと" do
      product = build(:product, category_id: nil)
      product.valid?
      expect(product.errors[:category_id]).to include("を入力してください")
    end

    it "conditionが空では登録できないこと" do
      product = build(:product, condition: nil)
      product.valid?
      expect(product.errors[:condition]).to include("を入力してください")
    end

    it "delivery_costが空では登録できないこと" do
      product = build(:product, delivery_cost: nil)
      product.valid?
      expect(product.errors[:delivery_cost]).to include("を入力してください")
    end

    it "delivery_wayが空では登録できないこと" do
      product = build(:product, delivery_way: nil)
      product.valid?
      expect(product.errors[:delivery_way]).to include("を入力してください")
    end

    it "delivery_originが空では登録できないこと" do
      product = build(:product, delivery_origin: nil)
      product.valid?
      expect(product.errors[:delivery_origin]).to include("を入力してください")
    end

    it "preparatory_daysが空では登録できないこと" do
      product = build(:product, preparatory_days: nil)
      product.valid?
      expect(product.errors[:preparatory_days]).to include("を入力してください")
    end

    it "priceが空では登録できないこと" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    it "priceが半角数字以外の文字では登録できないこと" do
      product = build(:product, price: "３００")
      product.valid?
      expect(product).to be_invalid
    end

    it "priceが300未満であれば登録できないこと" do
      product = build(:product, price: "299")
      product.valid?
      expect(product).to be_invalid
    end

    it "priceが9999999を超えたら登録できないこと" do
      product = build(:product, price: "10000000")
      product.valid?
      expect(product).to be_invalid
    end

    it "priceが規定範囲内であれば登録できる" do
      category = create(:category)
      product = build(:product, price: "300", category_id: category.id)
      product.valid?
      expect(product).to be_valid
    end
  end
end