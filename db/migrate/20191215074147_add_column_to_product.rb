class AddColumnToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :description, :text, null: false
    add_column :products, :condition, :string, null: false
    add_column :products, :delivery_cost, :string, null: false
    add_column :products, :delivery_way, :string, null: false
    add_column :products, :delivery_origin, :string, null: false
    add_column :products, :preparatory_days, :string, null: false
  end
end
