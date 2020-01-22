class MypageController < ApplicationController
  def show # マイページ
  end

  def exhibiting
    @user = User.find(params[:id])
    @product = @user.products.page(params[:page]).per(12).order("created_at DESC")
    respond_to do |format|
      format.html
      format.js
    end
  end

  def card # 支払い方法
  end

  def identification # 本人確認
  end

  def profile # プロフィール
    @user = User.find(params[:id])
  end

  def logout # ログアウト
  end

end
