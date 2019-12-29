require 'rails_helper'
describe SignupController do
  describe 'GET #registration' do
    it "assigns the request user to @user" do
      user = create(:user)
      get :registration
      expect(assigns(:user)).to eq user
    end
    it "renders the :registration template" do
      user = create(:user)
      get :registration
      expect(response).to render_template :registration
    end
    # context 'log in' do
    #   before do
    #     login user
    #     get :index
    #   end
    #   it 'renders index' do
    #     expect(response).to render_template :index
    #   end
    # end

    # context 'not log in' do
    #   before do
    #     get :index
    #   end

      # it 'redirects to new_user_session_path' do
      #   expect(response).to redirect_to(new_user_session_path)
      # end
    # end
  end

end