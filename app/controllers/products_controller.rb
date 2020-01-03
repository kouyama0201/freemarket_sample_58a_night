class ProductsController < ApplicationController
  def index
    @products_ladies = Product.where(category_id: 1)
    @products_mens = Product.where(category_id: 206)
    @products_home_electronics = Product.where(category_id: 1204)
    @products_toys = Product.where(category_id: 686)
    @products_chanel = Product.where(brand_id: 4354)
    @products_louis_vuitton = Product.where(brand_id: 11025)
    @products_supreme = Product.where(brand_id: 4387)
    @products_nike = Product.where(brand_id: 6725)
  end

  def new
    @product = Product.new
    @product.images.build
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def category_child
    @category_child = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchild
    @category_grandchild = Category.find("#{params[:child_id]}").children
  end

  def size
    selected_grandchild = Category.find("#{params[:grandchild_id]}")
    if related_size_parent = selected_grandchild.sizes[0]
      @sizes = related_size_parent.children
    else
      selected_child = Category.find("#{params[:grandchild_id]}").parent
        if related_size_parent = selected_child.sizes[0]
          @sizes = related_size_parent.children
        end
    end
  end

  def delivery_way
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
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_way, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand, :size_id, images_attributes: [:id, :image] ).merge(user_id: current_user.id)
  end
end
