# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
# freemarket_sample_58a_night DB設計
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
|phone|integer|unique: true|
### Association
- has_one :address
- has_one :credit_card
- has_many :products
- has_many :comments
- has_maby :seller, class_name: "Transaction"
- has_many :buyer, class_name: "Transaction"

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building_name|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|exp_month|integer|null: false|
|exp_year|integer|null: false|
### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|description|text|null: false|
|category|refereces|null: false, foreign_key: true|
|size|string|null: false|
|brand|refereces|null: false, foreign_key: true|
|condition|string|null: false|
|delivery_cost|string|null: false|
|delivery_way|string|null: false|
|delivery_origin|string|null: false|
|preparatory_days|string|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- has_one :transaction
- has_many :images
- has_many :comments

## transactionsテーブル
|Column|Type|Options|
|------|----|-------|
|seller|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- belongs_to :product

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
- belongs_to :product

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestory|references|null: false, foreign_key: true|
### Association
- has_many :products
- has_ancestory

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :products

## ER図
![freemarket_sample_58a_night ER図](https://user-images.githubusercontent.com/54708394/69492139-cabc7400-0ee1-11ea-8543-7039443be4f4.jpeg)

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
