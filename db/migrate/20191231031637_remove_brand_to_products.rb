class RemoveBrandToProducts < ActiveRecord::Migration[5.0]
  def change
    remove_reference :products, :brand, foreign_key: true
  end
end
