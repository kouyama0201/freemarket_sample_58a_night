require 'rails_helper'
describe SignupController do
  let(:user) { create(:user) }
  let(:address) { create(:address)}

  context 'log in' do
    before do
      login user
    end

    describe 'GET #registration' do
      it "redirect_to the top page" do
        get :registration
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #phone' do
      it "redirect_to the top page" do
        get :phone
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #address' do
      it "redirect_to the top page" do
        get :address
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #pay_way' do
      it "redirect_to the top page" do
        get :pay_way
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #complete' do
      it "renders the :complete template" do
        get :complete
        expect(response).to render_template :complete
      end
    end
  end

  context 'log out' do

    describe 'GET #registration' do
      it "render the :registration template" do
        get :registration
        expect(response).to render_template :registration
      end
    end

    describe 'GET #phone' do
      context 'registrationで入力不備がない場合' do
        it "render the :phone template" do
          get :phone, params: {user: attributes_for(:user)}
          expect(response).to render_template :phone
        end
      end
      context 'registrationで入力不備がある場合' do
        it "render the :registration template" do
          get :phone, params: {user: attributes_for(:user, name: nil)}
          expect(response).to render_template :registration
        end
      end
    end

    describe 'GET #address' do
      context 'phoneで入力不備がない場合' do
        it "render the :address template" do
          get :address,
          params: {
            user: {
              phone: "0123456789"
            }
          },
          session: {
            name: "ニックネーム",
            email: "abc@gmail.com",
            password: "abc1234567",
            password_confirmation: "abc1234567",
            lastname: "山田",
            firstname: "太郎",
            lastname_kana: "ヤマダ",
            firstname_kana: "タロウ",
            birth_year: "1992",
            birth_month: "10",
            birth_day: "14"
          }          
          expect(response).to render_template :address
        end
      end
      context 'phoneで入力不備がある場合' do
        it "render the :phone template" do
          get :address,
          params: {
            user: {
              phone: ""
            }
          },
          session: {
            name: "ニックネーム",
            email: "abc@gmail.com",
            password: "abc1234567",
            password_confirmation: "abc1234567",
            lastname: "山田",
            firstname: "太郎",
            lastname_kana: "ヤマダ",
            firstname_kana: "タロウ",
            birth_year: "1992",
            birth_month: "10",
            birth_day: "14"
          }          
          expect(response).to render_template :phone
        end
      end
    end

    describe 'GET #pay_way' do
      context 'addressで入力不備がない場合' do
        it "render the :pay_way template" do
          get :pay_way,
          params: {
            user: {
              lastname: "山田",
              firstname: "太郎",
              lastname_kana: "ヤマダ",
              firstname_kana: "タロウ",
              address_attributes: {
                postal_code:  "123-4567",
                prefecture_id:  "1",
                city: "名古屋市",
                street: "中区1-2-3",
                building_name:  "Bビル",
                phone_optional: "0123456789"
              }
            }
          },
          session: {
            name: "ニックネーム",
            email: "abc@gmail.com",
            password: "abc1234567",
            password_confirmation: "abc1234567",
            lastname: "山田",
            firstname: "太郎",
            lastname_kana: "ヤマダ",
            firstname_kana: "タロウ",
            birth_year: "1992",
            birth_month: "10",
            birth_day: "14",
            phone: "0123456789"
          }          
          expect(response).to render_template :pay_way
        end
      end
      context 'addressで入力不備がある場合' do
        it "render the :address template" do
          get :pay_way,
          params: {
            user: {
              lastname: "山田",
              firstname: "太郎",
              lastname_kana: "ヤマダ",
              firstname_kana: "タロウ",
              address_attributes: {
                  postal_code:  "",
                  prefecture_id:  "1",
                  city: "名古屋市",
                  street: "中区1-2-3",
                  building_name:  "Bビル",
                  phone_optional: "0123456789"
              }
            }
          },
          session: {
            name: "ニックネーム",
            email: "abc@gmail.com",
            password: "abc1234567",
            password_confirmation: "abc1234567",
            lastname: "山田",
            firstname: "太郎",
            lastname_kana: "ヤマダ",
            firstname_kana: "タロウ",
            birth_year: "1992",
            birth_month: "10",
            birth_day: "14",
            phone: "0123456789"
          }          
          expect(response).to render_template :address
        end
      end
    end

    describe 'POST #create' do
      context 'pay_wayで入力不備がない場合(SNS認証なし)' do
        it "returns http success" do
          post :create
          expect(response).to have_http_status "200"
        end

        it 'create a user record in DB' do
            expect {
              post :create,
              session: {
                name: "ニックネーム",
                email: "abc@gmail.com",
                password: "abc1234567",
                password_confirmation: "abc1234567",
                lastname: "山田",
                firstname: "太郎",
                lastname_kana: "ヤマダ",
                firstname_kana: "タロウ",
                birth_year: "1992",
                birth_month: "10",
                birth_day: "14",
                phone: "0123456789",
                address: {
                  postal_code:  "123-4567",
                  prefecture_id:  "1",
                  city: "名古屋市",
                  street: "中区1-2-3",
                  building_name:  "Bビル",
                  phone_optional: "0123456789"
                }
              }          
            }.to change(User, :count).by(1)
        end

        it 'create a address record in DB' do
            expect {
              post :create,
              session: {
                user_id: user.id,
                name: "ニックネーム",
                email: "def@gmail.com",
                password: "abc1234567",
                password_confirmation: "abc1234567",
                lastname: "山田",
                firstname: "太郎",
                lastname_kana: "ヤマダ",
                firstname_kana: "タロウ",
                birth_year: "1992",
                birth_month: "10",
                birth_day: "14",
                phone: "0234567891",
                address: {
                  postal_code:  "123-4567",
                  prefecture_id:  "1",
                  city: "名古屋市",
                  street: "中区1-2-3",
                  building_name:  "Bビル",
                  phone_optional: "0234567891"
                }
              }          
            }.to change(Address, :count).by(1)
        end

        it 'does not create a sns_credential record in DB' do
            expect {
              post :create,
              session: {
                user_id: user.id,
                name: "ニックネーム",
                email: "def@gmail.com",
                password: "abc1234567",
                password_confirmation: "abc1234567",
                lastname: "山田",
                firstname: "太郎",
                lastname_kana: "ヤマダ",
                firstname_kana: "タロウ",
                birth_year: "1992",
                birth_month: "10",
                birth_day: "14",
                phone: "0234567891",
                provider: nil,
                uid: nil,
                address: {
                  postal_code:  "123-4567",
                  prefecture_id:  "1",
                  city: "名古屋市",
                  street: "中区1-2-3",
                  building_name:  "Bビル",
                  phone_optional: "0234567891",
                }

              }          
            }.not_to change(SnsCredential, :count)
        end
      end

      context 'pay_wayで入力不備がない場合(SNS認証あり)' do
        it 'create a sns_credential record in DB' do
            expect {
              post :create,
              session: {
                user_id: user.id,
                name: "ニックネーム",
                email: "def@gmail.com",
                password: "abc1234567",
                password_confirmation: "abc1234567",
                lastname: "山田",
                firstname: "太郎",
                lastname_kana: "ヤマダ",
                firstname_kana: "タロウ",
                birth_year: "1992",
                birth_month: "10",
                birth_day: "14",
                phone: "0234567891",
                provider: "aaaaa",
                uid: "11",
                address: {
                  postal_code:  "123-4567",
                  prefecture_id:  "1",
                  city: "名古屋市",
                  street: "中区1-2-3",
                  building_name:  "Bビル",
                  phone_optional: "0234567891"
                }
              }          
            }.to change(SnsCredential, :count).by(1)
        end
      end


      context 'pay_wayで入力不備がある場合' do
        it "render the :pay_way template" do
          post :create,
          params: {
              card: {
              card_number: "",
              exp_month: "12",
              exp_year: "20",
              cvc: "123"
            }
          },
          session: {
            name: "ニックネーム",
            email: "abc@gmail.com",
            password: "abc1234567",
            password_confirmation: "abc1234567",
            lastname: "山田",
            firstname: "太郎",
            lastname_kana: "ヤマダ",
            firstname_kana: "タロウ",
            birth_year: "1992",
            birth_month: "10",
            birth_day: "14",
            phone: "0123456789",
            address: {
              postal_code:  "123-4567",
              prefecture_id:  "1",
              city: "名古屋市",
              street: "中区1-2-3",
              building_name:  "Bビル",
              phone_optional: "0123456789"
            }
          }          
          expect(response).to redirect_to pay_way_signup_index_path
        end
      end
    end

  end
end