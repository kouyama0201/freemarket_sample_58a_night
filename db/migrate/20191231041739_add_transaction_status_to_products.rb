class AddTransactionStatusToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :transaction_status, :integer, default: 0
    add_column :products, :buyer_id, :integer
  end
end
