module ApplyGon #gonの呼び出し
  extend ActiveSupport::Concern

  private
  def apply_gon
    gon.payjp_key = ENV["PAYJP_KEY"] # jsエラー回避用の記述
  end
end