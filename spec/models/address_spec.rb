require 'rails_helper'
describe Address do
  describe '#create' do
    it "is valid with all information" do
      user = create(:user)
      address = build(:address, user_id: user.id)
      expect(address).to be_valid
    end
    it "is invalid without a postal_code" do
      user = create(:user)
      address = build(:address, postal_code: "", user_id: user.id)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end
    it "is invalid without a prefecture_id" do
      user = create(:user)
      address = build(:address, prefecture_id: "", user_id: user.id)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end
    it "is invalid without a city" do
      user = create(:user)
      address = build(:address, city: "", user_id: user.id)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end
    it "is invalid without a street" do
      user = create(:user)
      address = build(:address, street: "", user_id: user.id)
      address.valid?
      expect(address.errors[:street]).to include("can't be blank")
    end
    it "is invalid with a duplicate phone_optional" do
      user = create(:user)
      address = create(:address, phone_optional: "0123456789", user_id: user.id)
      another_user2 = create(:user, email: "bbb@gmail.com", phone: "0987654321")
      another_address = build(:address, phone_optional: "0123456789", user_id: another_user2.id)
      another_address.valid?
      expect(another_address.errors[:phone_optional]).to include("has already been taken")
    end
    it "postal_codeが正しくないフォーマットの場合、invalidとなるか？" do
      user = create(:user)
      address = build(:address, postal_code: "aaaaaaaa", user_id: user.id)
      expect(address).to be_invalid
    end
    it "phone_optionalが正しくないフォーマットの場合、invalidとなるか？" do
      user = create(:user)
      address = build(:address, phone_optional: "aaaaaaaaaaa", user_id: user.id)
      expect(address).to be_invalid
    end
  end
end