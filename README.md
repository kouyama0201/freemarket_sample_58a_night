# freemarket_sample_58a_night
プログラミングスクールTECH::EXPERTの最終課題でフリーマーケットサイトを作成しました。
# リンク
http://3.113.61.111/

BASIC認証をかけています。ご覧の際は下記のIDとPassを入力してください。
+ BASIC認証
  + ID:58anight
  + Pass:58anight

# テストユーザー
+ 購入用アカウント
  + メールアドレス:buyer@test.com  
  + パスワード:buyer123
+ 購入用カード情報
  + 番号:4242424242424242
  + 期限:12/20
  + セキュリティコード:123
+ 出品用アカウント
  + メールアドレス:seller@test.com  
  + パスワード:seller123

# kouyama0201の担当箇所
## DB設計
## 商品出品機能
### 画像複数投稿
[![Screenshot from Gyazo](https://gyazo.com/84ab861c64ef0f7ea6f8f13f2180df7a/raw)](https://gyazo.com/84ab861c64ef0f7ea6f8f13f2180df7a)
+ jQueryとgem 'carrierwave'を用いて、プレビュー可能な画像複数投稿機能(10枚まで)を実装しました。<br>
※ドラッグアンドドロップは非対応です。

### jQueryによる動的な入力フォーム
[![Screenshot from Gyazo](https://gyazo.com/d3606b5f50feaa2721f2eba57c853e83/raw)](https://gyazo.com/d3606b5f50feaa2721f2eba57c853e83)
+ カテゴリー・サイズ・ブランド・配送の方法の入力フォームをjQueryにてAjaxで実装しました。
### 販売利益の自動計算
+ 入力した価格に応じて販売利益を自動計算する機能をjQueryにて実装しました。

## 商品編集機能
## 商品検索機能
+ キーワード検索機能とgem 'ransack'を用いての詳細検索機能を実装しました。

## その他
### 商品出品・編集時のバリデーション
[![Screenshot from Gyazo](https://gyazo.com/5450006eae2047b1316197f6fc457bbf/raw)](https://gyazo.com/5450006eae2047b1316197f6fc457bbf)

[jQueryによる動的なバリデーションチェック](https://github.com/tiphp452/freemarket_sample_58a_night/blob/master/app/assets/javascripts/jquery.validate.handler.product.js)を実装しました。
### 単体テスト(RSpec)
+ 商品関連メソッド(new, create, edit, update)の単体テスト
+ 商品モデルの単体テスト

# DB設計
## ER図
![freemarket_sample_58a_night ER図](https://user-images.githubusercontent.com/54708394/73121017-d1866680-3fb8-11ea-8762-e36d25af5e3d.jpeg)

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|avatar|string||
|introduction|text||
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone|string|unique: true|
### Association
- has_one :address, dependent: :destroy
- has_one :credit_card, dependent: :destroy
- has_one :sns_credential, dependent: :destroy
- has_many :products
- has_many :comments

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building_name|string||
|phone_optional|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user, inverse_of: :address

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|null: false|
|provider|string|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|description|text|null: false|
|category|references|null: false, foreign_key: true|
|size|references|foreign_key: true|
|brand|references|foreign_key: true|
|condition|string|null: false|
|delivery_cost|string|null: false|
|delivery_way|string|null: false|
|delivery_origin|string|null: false|
|preparatory_days|string|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|
|transaction_status|integer|default: 0|
|buyer_id|integer||
### Association
- belongs_to :user
- belongs_to :category
- belongs_to :size, optional: true
- belongs_to :brand
- has_many :images, dependent: :destroy
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :comments, dependent: :destroy

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product|references|null: false, foreign_key: true|
### Association
- belongs_to :product, inverse_of: :images

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestory|references|null: false, foreign_key: true|
### Association
- has_many :products
- has_many :category_sizes
- has_many :sizes, through: :category_sizes
- has_ancestory

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string||
|ancestry|references|null: false, foreign_key: true|
### Association
- has_many :products
- has_many :category_sizes
- has_many :categories, through: :category_sizes
- has_ancestry

## category_sizesテーブル
|Column|Type|Options|
|------|----|-------|
|category|references|foreign_key: true|
|size|references|foreign_key: true|
### Association
- belongs_to :category
- belongs_to :size

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :products