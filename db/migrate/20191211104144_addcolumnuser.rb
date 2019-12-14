class Addcolumnuser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :introduction, :text
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname_kana, :string
    add_column :users, :firstname_kana, :string
    add_column :users, :birth_year, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_day, :integer
    add_column :users, :phone, :integer
  end
end
