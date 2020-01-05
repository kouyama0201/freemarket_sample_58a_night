require 'rails_helper'
describe Users::SessionsController do
  let(:user) { create(:user) }
  let(:address) { create(:address)}

  context 'log in' do
    before do
      login user
    end

    describe 'GET #new' do
      it "redirect_to the top page" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'log out' do
    describe 'GET #new' do
      it "renders the :new template" do
        request.env["devise.mapping"] = Devise.mappings[:user]
        get :new
        expect(response).to render_template :new
      end
    end
  end



end
