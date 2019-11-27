require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid with a email" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid without a duplicate email address" do
      user = build(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

  end
end