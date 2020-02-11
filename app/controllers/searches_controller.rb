class SearchesController < ApplicationController
  before_action :set_ransack
  before_action :set_parents

  def index
    @products = Product.search(params[:search]).where.not(transaction_status: 2).page(params[:page]).per(20).order("created_at DESC")
    @search = params[:search]
  end

  def detail_search
    @search_product = Product.ransack(params[:q]) 
    @products = @search_product.result.page(params[:page]).per(20).order("created_at DESC")
  end

  private
  def set_ransack
    @q = Product.ransack(params[:q])
  end
end
