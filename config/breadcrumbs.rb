crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", mypage_products_path
end

# crumb :profile do
#   link "プロフィール", root_path
#   parent :mypage
# end

crumb :card do
  link "支払い方法", card_products_path
  parent :mypage
end

# crumb :personal do
#   link "本人情報の確認", root_path
#   parent :mypage
# end

crumb :logout do
  link "ログアウト", logout_products_path
  parent :mypage
end
