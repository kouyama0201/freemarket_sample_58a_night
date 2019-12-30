class PurchaseController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def pay

  end

  def complete

  end
end
