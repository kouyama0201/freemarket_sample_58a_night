class SearchesController < ApplicationController
  def index
    @products = Product.search(params[:search]).where.not(transaction_status: 2).page(params[:page]).per(20).order("created_at DESC")
    @search = params[:search]
  end
end
