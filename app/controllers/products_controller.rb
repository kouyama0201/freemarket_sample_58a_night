class ProductsController < ApplicationController
  before_action :apply_gon
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:edit, :show]
  before_action :set_parents, only: [:index, :show]

  def index
    @products_ladies = Product.where(category_id: 1..205).where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_mens = Product.where(category_id: 206..350).where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_home_electronics = Product.where(category_id: 899..984).where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_toys = Product.where(category_id: 686..798).where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_chanel = Product.where(brand: "シャネル").where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_louis_vuitton = Product.where(brand: "ルイヴィトン").where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_supreme = Product.where(brand: "シュプリーム").where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @products_nike = Product.where(brand: "ナイキ").where.not(transaction_status: 2).order("created_at DESC").limit(10)
    @parents = Category.where(ancestry: nil)
    parent_id = params[:parent_id]
    @children = Category.find_by(parent_id).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @product = Product.new
    @product.images.build
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end

  def category_child
    @category_child = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def show
    @main_photo = @product.images[0]
    @prefecture = Prefecture.find(@product.delivery_origin.to_i)
    @category_grandchildren = @product.category
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
      redirect_to root_path, notice: '商品を出品しました。'
    else
      @product.images.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      render new_product_path(@product)
    end
  end

  def edit
    @profit = (@product.price * 0.1).floor
    @fee = @product.price - @profit
    # 以下孫カテゴリーから親カテゴリーを辿る際の記述
    # 選択された孫カテゴリ
    @selected_grandchild = @product.category
    # idとnameをハッシュの配列化
    @category_grandchild_array = [{id: "", name: "---"}]
    #siblingsにて同じ階層の要素をすべて取得
    Category.find("#{@selected_grandchild.id}").siblings.each do |grandchild|
      grandchild_hash = {id: "#{grandchild.id}", name: "#{grandchild.name}"}
      @category_grandchild_array << grandchild_hash
    end
    # 子カテゴリで上記と同様の記述
    @selected_child = @selected_grandchild.parent
    @category_child_array = [{id: "", name: "---"}]
    Category.find("#{@selected_child.id}").siblings.each do |child|
      child_hash = {id: "#{child.id}", name: "#{child.name}"}
      @category_child_array << child_hash
    end
    # 親カテゴリで上記と同様の記述
    @selected_parent = @selected_child.parent
    @category_parent_array = []
    Category.find("#{@selected_parent.id}").siblings.each do |parent|
      parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
      @category_parent_array << parent_hash
    end
    # サイズが登録されている場合
    if @selected_size = @product.size
      # 登録されているサイズに関連する、サイズ選択肢用の配列作成
      @size_array = [{id: "", size: "---"}]
      Size.find("#{@selected_size.id}").siblings.each do |size|
        size_hash = {id: "#{size.id}", size: "#{size.size}"}
        @size_array << size_hash
      end
    else # サイズが登録されていない場合
      @selected_size = nil
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_update_params) && product.user_id == current_user.id
      redirect_to product_path(product), notice: '商品の編集が完了しました。'
    else
      redirect_to edit_product_path(product), alert: '画像が無い為、更新ができませんでした。'
    end
  end

  def release
    product = Product.find(params[:id])
    product.update(transaction_status: "0")
    redirect_to product_path(product), notice: '出品の再開をしました。'
  end

  def suspension
    product = Product.find(params[:id])
    product.update(transaction_status: "2")
    redirect_to product_path(product), notice: '出品の一旦停止をしました。'
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.user_id == current_user.id && @product.destroy
      redirect_to root_path, notice: '商品を削除しました。'
    else
      redirect_to edit_product_path, alert: '商品の削除に失敗しました。'
    end
  end

  def brand
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(100)
    respond_to do |format|
      format.json
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_way, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand, :size_id, images_attributes: [:id, :image] ).merge(user_id: current_user.id)
  end

  def product_update_params
    params.require(:product).permit(:name, :description, :condition, :delivery_cost, :delivery_way, :delivery_origin, :preparatory_days, :price,
                                    :category_id, :brand, :size_id, images_attributes: [:id, :image, :_destroy] ).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def apply_gon
    gon.payjp_key = ENV["PAYJP_KEY"]
  end
end