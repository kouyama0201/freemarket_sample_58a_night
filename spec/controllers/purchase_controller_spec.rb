require 'rails_helper'
describe PurchaseController, type: :controller do
  let(:user) { create(:user) }
  let(:card) { create(:card) }
  describe 'GET #show' do
      context 'ログイン時' do
      before do
        login user
      end
      it "@productは正しくアサインされるか" do
        card = create(:card, user_id: user.id)
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_customer_information)
        product = create(:product)
        get :show, params: { id: product }
        expect(assigns(:product)).to eq product
      end
      it "showアクションのページに遷移するか" do
        card = create(:card, user_id: user.id)
        allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_customer_information)
        product = create(:product)
        get :show, params: { id: product }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #pay' do
      context 'ログイン時' do
      before do
        login user
      end
      it "@productは正しくアサインされるか" do
        card = create(:card, user_id: user.id)
        allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)        
        product = create(:product)
        get :pay, params: { id: product }
        expect(assigns(:product)).to eq product
      end
      it "購入が完了しトップページに遷移するか" do
        card = create(:card, user_id: user.id)
        allow(Payjp::Charge).to receive(:create).and_return(PayjpMock.prepare_valid_charge)        
        product = create(:product)
        get :pay, params: { id: product }
        expect(response).to redirect_to root_path
      end
    end
  end
end