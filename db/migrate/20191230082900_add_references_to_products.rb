class AddReferencesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :size, foreign_key: true
    add_column :products, :delivery_way, :string, null: false
  end
end
