class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.images.build
    @category_options = [
                          {id: 0, name: "---"},
                          {id: 1, name: "レディース"},
                          {id: 206, name: "メンズ"},
                          {id: 351, name: "ベビー・キッズ"},
                          {id: 486, name: "インテリア・住まい・小物"},
                          {id: 627, name: "本・音楽・ゲーム"},
                          {id: 686, name: "おもちゃ・ホビー・グッズ"},
                          {id: 799, name: "コスメ・香水・美容"},
                          {id: 1204, name: "家電・スマホ・カメラ"},
                          {id: 985, name: "スポーツ・レジャー"},
                          {id: 1094, name: "ハンドメイド"},
                          {id: 1145, name: "チケット"},
                          {id: 1204, name: "自動車・オートバイ"},
                          {id: 1266, name: "その他"}
                        ]
    @brand_options = [
                        {id: 0, name: "---"},
                        {id: 4354, name: "シャネル"},
                        {id: 4387, name: "シュープリーム"},
                        {id: 6725, name: "ナイキ"},
                        {id: 11025, name: "ルイ ヴィトン"},
                      ]
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render new_product_path
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def logout
  end

  def purchase_confirmation
  end

  def card
  end

  def card_registration
  end

  def mypage
  end

  def identification
  end

  def profile
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand_id, images_attributes: [:id, :image]).merge(user_id: current_user.id)
  end
end
