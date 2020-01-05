class ChangeDatatypeAddressOfPostalCode < ActiveRecord::Migration[5.0]
  def change
    change_column :addresses, :postal_code, :string
  end
end
