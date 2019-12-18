class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render new_product_path
    end
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

  def identification
  end

  def profile
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_origin, :preparatory_days, :price, images_attributes: [:id, :image]).merge(user_id: current_user.id)
  end
end
