module RedirectToTop
  extend ActiveSupport::Concern

  private

  def redirect_to_top
    redirect_to products_path unless user_signed_in?
  end

end