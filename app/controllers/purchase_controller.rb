class PurchaseController < ApplicationController
  include SetCard
  before_action :set_card, only: [:show]
  
  def show
    gon.payjp_key = ENV["PAYJP_KEY"] # JSエラー回避用の記述
    @product = Product.find(params[:id])
    @image = @product.images.first
    @card = Card.where(user_id: current_user).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
    @address = Address.find_by(user_id: current_user)
  end

  def pay
    @product = Product.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']#保管した顧客IDでpayjpから情報取得
    Payjp::Charge.create(
    amount: @product.price, #支払金額
    customer: card.customer_id, #顧客ID
    currency: 'jpy', #日本円
    )
    @product.buyer_id = current_user.id 
    @product.transaction_status = 1
    if @product.update(product_params)
      redirect_to root_path, notice: '商品の購入が完了しました'
    else
      redirect_to purchase_path
    end
  end
  
  private
  def product_params
    params.permit(:buyer_id, :transaction_status)
  end
end
