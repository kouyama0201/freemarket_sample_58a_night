class ChangeColumnNullUser < ActiveRecord::Migration[5.0]
  def up
    change_column_null  :users, :name, false, ""
    change_column       :users, :name, :string, default: ""
    change_column_null  :users, :lastname, false, ""
    change_column       :users, :lastname, :string, default: ""
    change_column_null  :users, :firstname, false, ""
    change_column       :users, :firstname, :string, default: ""
    change_column_null  :users, :lastname_kana, false, ""
    change_column       :users, :lastname_kana, :string, default: ""
    change_column_null  :users, :firstname_kana, false, ""
    change_column       :users, :firstname_kana, :string, default: ""
    change_column_null  :users, :birth_year, false, 0
    change_column       :users, :birth_year, :integer, default: 0
    change_column_null  :users, :birth_month, false, 0
    change_column       :users, :birth_month, :integer, default: 0
    change_column_null  :users, :birth_day, false, 0
    change_column       :users, :birth_day, :integer, default: 0
  end

  def down
    change_column_null  :users, :name, true, nil
    change_column       :users, :name, :string, default: nil
    change_column_null  :users, :lastname, true, nil
    change_column       :users, :lastname, :string, default: nil
    change_column_null  :users, :firstname, true, nil
    change_column       :users, :firstname, :string, default: nil
    change_column_null  :users, :lastname_kana, true, nil
    change_column       :users, :lastname_kana, :string, default: nil
    change_column_null  :users, :firstname_kana, true, nil
    change_column       :users, :firstname_kana, :string, default: nil
    change_column_null  :users, :birth_year, true, nil
    change_column       :users, :birth_year, :integer, default: nil
    change_column_null  :users, :birth_month, true, nil
    change_column       :users, :birth_month, :integer, default: nil
    change_column_null  :users, :birth_day, true, nil
    change_column       :users, :birth_day, :integer, default: nil
  end
end
