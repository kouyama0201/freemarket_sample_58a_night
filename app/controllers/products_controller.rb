class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @product.images.build
    @category_parent_array = Category.where(ancestry: nil)
    p  @category_parent_array
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
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @brand_options = [
        {id: 0, name: "---"},
        {id: 4354, name: "シャネル"},
        {id: 4387, name: "シュープリーム"},
        {id: 6725, name: "ナイキ"},
        {id: 11025, name: "ルイ ヴィトン"},
      ]
      binding.pry
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

  def show
    @product = Product.find(params[:id])
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand_id, images_attributes: [:id, :image]).merge(user_id: current_user.id)
  end
end
