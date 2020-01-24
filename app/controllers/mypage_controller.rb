class MypageController < ApplicationController
  include ApplyGon
  before_action :apply_gon

  def show # マイページ
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
