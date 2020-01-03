class CreateSnsCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :sns_credentials do |t|
      t.string :uid, :string
      t.string :provider, :string
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
