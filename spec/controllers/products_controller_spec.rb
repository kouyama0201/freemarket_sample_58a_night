require 'rails_helper'

describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #new' do
    context 'ログイン時' do
      before do
        login user
      end
      
      it "newアクションのページに遷移するか" do
        get :new
        expect(response).to render_template :new
      end
    end

    it "未ログイン時にログインページへ遷移するか" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST #create' do

    context 'ログイン時' do
      before do
        login user
      end

      context 'セーブが成功した場合' do

        it '商品が登録されること' do
          image_params = { images_attributes:[FactoryBot.attributes_for(:image), FactoryBot.attributes_for(:image)]}
          product = {product: FactoryBot.attributes_for(:product).merge(image_params, category_id: category.id, user_id: user.id)}
          expect{
            post :create, params: product
          }.to change(Product, :count).by(1)
        end

        it 'トップページにリダイレクトすること' do
          image_params = { images_attributes:[FactoryBot.attributes_for(:image), FactoryBot.attributes_for(:image)]}
          product = {product: FactoryBot.attributes_for(:product).merge(image_params, category_id: category.id, user_id: user.id)}
          post :create, params: product
          expect(response).to redirect_to root_path
        end

      end

      context 'セーブが失敗した場合' do

        it '商品が登録されないこと' do
          image_params = { images_attributes:[FactoryBot.attributes_for(:image), FactoryBot.attributes_for(:image)]}
          product = {product: FactoryBot.attributes_for(:product, name: "").merge(image_params, category_id: category.id, user_id: user.id)}
          expect{ 
            post :create, params: product
          }.not_to change(Product, :count)
        end

        it 'レンダリング先に遷移するかどうか' do
          image_params = { images_attributes:[FactoryBot.attributes_for(:image), FactoryBot.attributes_for(:image)]}
          product = {product: FactoryBot.attributes_for(:product, name: "").merge(image_params, category_id: category.id, user_id: user.id)}
          post :create, params: product
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET #show' do

    context 'ログイン時' do
      before do
        login user
      end

      it "正常なレスポンスか" do
        get :index
        expect(response).to be_success
      end

      it "200レスポンスが返ってきているか" do
          get :index
          expect(response).to have_http_status "200"
      end

      it "showアクションのページに遷移するか" do
        product = create(:product)
        get :show, params: { id: product }
        expect(response).to render_template :show
      end

      it "@productは正しくアサインされるか" do
        product = create(:product)
        get :show, params: { id: product }
        expect(assigns(:product)).to eq product
      end
    end

    it "未ログイン時に正常なレスポンスか" do
      get :index
      expect(response).to be_success
    end

    it "未ログイン時に200レスポンスが返ってきているか" do
        get :index
        expect(response).to have_http_status "200"
    end

    it "未ログイン時にshowアクションのページに遷移するか" do
      product = create(:product)
      get :show, params: { id: product }
      expect(response).to render_template :show
    end
  end

end