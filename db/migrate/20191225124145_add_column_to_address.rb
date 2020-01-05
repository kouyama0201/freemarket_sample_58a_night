class AddColumnToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :phone_optional, :string
  end
end
