class CardController < ApplicationController
  include SetCard
  before_action :set_card, only: [:new, :delete, :show]

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def new # マイページでのカード情報入力
    gon.payjp_key = ENV["PAYJP_KEY"]
    redirect_to action: "show" if @card.present?
  end

  def create # マイページでのカード情報登録
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(current_user)
      else
        redirect_to action: "new"
      end
    end
  end

  def delete # マイページでのカード情報削除
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      redirect_to card_path(current_user)
    end
  end

  def show # マイページでのカード情報表示
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

end
