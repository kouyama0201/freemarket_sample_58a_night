class SnsCredential < ApplicationRecord
  belongs_to :user
  def self.from_omniauth(auth)
    # SNS登録されている場合は取得、されていない場合には作成
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
