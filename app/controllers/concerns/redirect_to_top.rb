# ログインしてない場合にトップページに遷移するメソッド
module RedirectToTop
  extend ActiveSupport::Concern

  private

  def redirect_to_top
    redirect_to products_path if user_signed_in?
  end

end