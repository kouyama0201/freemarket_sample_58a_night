class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :prefecture_id
      t.string :city, null: false, default: ""
      t.integer :postal_code, null: false
      t.string :street, null: false, default: ""
      t.string :building_name
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
