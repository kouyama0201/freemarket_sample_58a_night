crumb :root do
  link "フリマ", root_path
end

crumb :search do
  link "", searches_path
  parent :root
end

crumb :product do |product|
  link product.name, product_path(product)
  parent :root
end

crumb :mypage do
  link "マイページ", mypage_path(current_user)
end

crumb :exhibiting do
  link "出品した商品 - 出品中", exhibiting_mypage_path(current_user)
  parent :mypage
end

crumb :sold do
  link "出品した商品 - 売却済み", sold_mypage_path(current_user)
  parent :mypage
end

crumb :purchased do
  link "購入した商品 - 過去の取引", purchased_mypage_path(current_user)
  parent :mypage
end

crumb :profile do
  link "プロフィール", profile_mypage_path
  parent :mypage
end

crumb :card do
  link "支払い方法", card_path(current_user)
  parent :mypage
end

crumb :personal do
  link "本人情報の登録", identification_mypage_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_mypage_path(current_user)
  parent :mypage
end