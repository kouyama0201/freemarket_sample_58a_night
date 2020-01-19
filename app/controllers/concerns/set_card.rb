module SetCard #登録済みのクレジットカードの呼び出し
  extend ActiveSupport::Concern

  private
  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end