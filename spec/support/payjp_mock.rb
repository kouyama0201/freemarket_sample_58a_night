module PayjpMock
  def self.prepare_valid_charge # Payjp::Chargeのレスポンスモック
    {
      "amount": 3500,
      "amount_refunded": 0,
      "captured": true,
      "captured_at": 1433127983,
      "card": {
        "address_city": nil,
        "address_line1": nil,
        "address_line2": nil,
        "address_state": nil,
        "address_zip": nil,
        "address_zip_check": "unchecked",
        "brand": "Visa",
        "country": nil,
        "created": 1433127983,
        "customer": nil,
        "cvc_check": "unchecked",
        "exp_month": 2,
        "exp_year": 2020,
        "fingerprint": "e1d8225886e3a7211127df751c86787f",
        "id": "car_d0e44730f83b0a19ba6caee04160",
        "last4": "4242",
        "name": nil,
        "object": "card"
      },
      "created": 1433127983,
      "currency": "jpy",
      "customer": nil,
      "description": nil,
      "expired_at": nil,
      "failure_code": nil,
      "failure_message": nil,
      "id": "ch_fa990a4c10672a93053a774730b0a",
      "livemode": false,
      "metadata": nil,
      "object": "charge",
      "paid": true,
      "refund_reason": nil,
      "refunded": false,
      "subscription": nil
    }
  end

  def self.prepare_customer_information # Payjp::Customerのレスポンスモック
    {
      "id": "cus_ca9d1d98900ec1f2595aebefd9a6",
      "cards": {
        "count":1,
        "data":[{
          "id":"car_a96c76b044d7ae21439d7b9840b7",
          "address_city":nil,
          "address_line1":nil,
          "address_line2":nil,
          "address_state":nil,
          "address_zip":nil,
          "address_zip_check":"unchecked",
          "brand":"Visa",
          "country":nil,
          "created":1578830630,
          "customer":"cus_ca9d1d98900ec1f2595aebefd9a6",
          "cvc_check":"passed",
          "exp_month":12,
          "exp_year":2020,
          "fingerprint":"e1d8225886e3a7211127df751c86787f",
          "last4":"4242",
          "livemode":false,
          "metadata":{},
          "name":nil,
          "object":"card"
          }],
          "has_more":false,
          "object":"list",
          "url":"/v1/customers/cus_ca9d1d98900ec1f2595aebefd9a6/cards"
        },
      "created": 1578830631,
      "default_card": "car_a96c76b044d7ae21439d7b9840b7",
      "description": nil,
      "email": nil,
      "livemode": false,
      "metadata": {},
      "object": "customer",
      "subscriptions": {
        "count":0,
        "data":[],
        "has_more":false,
        "object":"list",
        "url":"/v1/customers/cus_ca9d1d98900ec1f2595aebefd9a6/subscriptions"
      }
    }
  end
end