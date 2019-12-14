class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to root_path
  end

  def detail
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

  private
  def product_params
    params.require(:product).permit(:name, :price).merge(user_id: current_user.id)
  end
end
