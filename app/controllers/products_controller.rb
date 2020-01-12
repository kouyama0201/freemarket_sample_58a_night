class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products_ladies = Product.where(category_id: 1..205).order("created_at DESC").limit(10)
    @products_mens = Product.where(category_id: 206..350).order("created_at DESC").limit(10)
    @products_home_electronics = Product.where(category_id: 899..984).order("created_at DESC").limit(10)
    @products_toys = Product.where(category_id: 686..798).order("created_at DESC").limit(10)
    @products_chanel = Product.where(brand: "シャネル").order("created_at DESC").limit(10)
    @products_louis_vuitton = Product.where(brand: "ルイヴィトン").order("created_at DESC").limit(10)
    @products_supreme = Product.where(brand: "シュプリーム").order("created_at DESC").limit(10)
    @products_nike = Product.where(brand: "ナイキ").order("created_at DESC").limit(10)
  end

  def new
    @product = Product.new
    @product.images.build
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    gon.payjp_key = ENV["PAYJP_KEY"] # jsエラー回避用の記述
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
    if @product.valid?
      @product.save
      redirect_to root_path
    else
      @product.images.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      render new_product_path(@product)
    end
  end

  def detail
  end

  def purchase_confirmation
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_way, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand, :size_id, images_attributes: [:id, :image] ).merge(user_id: current_user.id)
  end
end
