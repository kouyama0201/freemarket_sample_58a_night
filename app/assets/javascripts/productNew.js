$(function () {
  // メソッドの定義
  var methods = {
    email: function (value, element) { // メールアドレスの正規表現 
      return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i.test(value);
    },
    password: function (value, element) { // パスワードの正規表現 
      return this.optional(element) || /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i.test(value);
    },
    valueNotEquals: function (value, element, arg) { // プルダウンリストが選択されているかの確認
      return arg !== value;
    },
    phone: function (value, element) { // 電話番号の正規表現
      return this.optional(element) || /^0\d{9,10}$/.test(value);
    },
    cardNumber: function (value, element) { // クレジットカード番号の正規表現
      return this.optional(element) || /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47]{13}|(?:2131|1800|35[0-9]{3})[0-9]{11})$/.test(value);
    },
    cvc: function (value, element) { // セキュリティコードの正規表現
      return this.optional(element) || /^\d{3,4}$/.test(value);
    },
    postalCode: function (value, element) { // 郵便番号の正規表現
      return this.optional(element) || /^\d{3}[-]\d{4}$/.test(value);
    },
    kana: function (value, element) { // カタカナの正規表現
      return this.optional(element) || /^[ァ-ヴ]+$/.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#signup-form, #charge-form").validate({
    // ルール設定
    rules: {
      "user[name]": {
        required: true
      },
      "user[email]": {
        required: true,
        email: true 
      },
      "user[password]": {
        required: true,
        password: true
      },
      "user[password_confirmation]": {
        required: true,
        password: true,
        equalTo: "#password"
      },
      "user[lastname]": {
        required: true
      },
      "user[firstname]": {
        required: true
      },
      "user[lastname_kana]": {
        required: true,
        kana: true
      },
      "user[firstname_kana]": {
        required: true,
        kana: true
      },
      "user[birth_year]": {
        valueNotEquals: "--"
      },
      "user[birth_month]": {
        valueNotEquals: "--"
      },
      "user[birth_day]": {
        valueNotEquals: "--"
      },
      "user[phone]": {
        required: true,
        phone: true
      },
      "user[address_attributes][postal_code]": {
        required: true,
        postalCode: true
      },
      "user[address_attributes][prefecture_id]": {
        valueNotEquals: ""
      },
      "user[address_attributes][city]": {
        required: true
      },
      "user[address_attributes][street]": {
        required: true
      },
      "user[address_attributes][building_name]": {},
      "user[address_attributes][phone_optional]": {
        phone: true
      },
      card_number: {
        required: true,
        cardNumber: true
      },
      exp_month: {
        valueNotEquals: ""
      },
      exp_year: {
        valueNotEquals: ""
      },
      cvc: {
        required: true,
        cvc: true
      }
    },
    // エラーメッセージの定義
    messages: {
      "user[name]": {
        required: "ニックネームを入力してください"
      },
      "user[email]": {
        required: "メールアドレスを入力してください",
        email: "フォーマットが不適切です"
      },
      "user[password]": {
        required: "パスワードを入力してください",
        password: "英字と数字両方を含むパスワードを入力してください"
      },
      "user[password_confirmation]": {
        required: "確認用パスワードを入力してください",
        password: "英字と数字両方を含むパスワードを入力してください",
        equalTo: "パスワードが一致していません"
      },
      "user[lastname]": {
        required: "姓を入力してください"
      },
      "user[firstname]": {
        required: "名を入力してください"
      },
      "user[lastname_kana]": {
        required: "姓カナを入力してください",
        kana: "姓カナをカタカナに変更してください"
      },
      "user[firstname_kana]": {
        required: "名カナを入力してください",
        kana: "名カナをカタカナに変更してください"
      },
      "user[birth_year]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[birth_month]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[birth_day]": {
        valueNotEquals: "生年月日を入力してください"
      },
      "user[phone]": {
        required: "電話番号を入力してください",
        phone: "フォーマットが不適切です"
      },
      "user[address_attributes][postal_code]": {
        required: "郵便番号を入力してください",
        postalCode: "フォーマットが不適切です"
      },
      "user[address_attributes][prefecture_id]": {
        valueNotEquals: "都道府県を選択してください"
      },
      "user[address_attributes][city]": {
        required: "市町村区を入力してください"
      },
      "user[address_attributes][street]": {
        required: "番地を入力してください"
      },
      "user[address_attributes][building_name]": {},
      "user[address_attributes][phone_optional]": {
        phone: "フォーマットが不適切です"
      },
      card_number: {
        required: "クレジットカード番号を入力してください",
        cardNumber: "有効なクレジットカード番号を入力してください"
      },
      exp_month: {
        valueNotEquals: "有効期限を選択してください"
      },
      exp_year: {
        valueNotEquals: "有効期限を選択してください"
      },
      cvc: {
        required: "セキュリティコードを入力してください",
        cvc: "4桁もしくは3桁の番号を入力してください"
      }
    },
    groups: { //グループ化
      exp_date: "exp_month exp_year"
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
    // エラーメッセージ表示位置のカスタム設定
    errorPlacement: function (error, element) {
      if (element.attr("name") == "user[lastname]" || element.attr("name") == "user[firstname]") {
        error.insertAfter("#name_error");
      }
      else if (element.attr("name") == "user[lastname_kana]" || element.attr("name") == "user[firstname_kana]") {
        error.insertAfter("#name_kana_error");
      }
      else if (element.attr("name") == "user[birth_year]" || element.attr("name") == "user[birth_month]" || element.attr("name") == "user[birth_day]") {
        $("#birth_month-error, #birth_day-error, #birth_year-error").remove();
        error.insertAfter("#birth_date_error");
      }
      else if (element.attr("name") == "user[address_attributes][prefecture_id]") {
        error.insertAfter("#prefecture_id_error");
      }
      else if (element.attr("name") == "card_number") {
        error.insertAfter("#card_number_error");
      }
      else if (element.attr("name") == "exp_month" || element.attr("name") == "exp_year") {
        error.insertAfter("#exp_date_error");
      }
      else {
        error.insertAfter(element);
      }
    }
  });
  // 入力欄or選択欄をフォーカスアウトしたときにバリデーションを実行(ウィザードページ毎)
  $("#name, #email, #password, #password_confirmation, #lastname, #firstname, #lastname_kana, #firstname_kana, #birth_year, #birth_month, #birth_day").blur(function () {
    $(this).valid();
  });
  $("#phone").blur(function () {
    $(this).valid();
  });
  $("#postal_code, #user_address_attributes_prefecture_id, #city, #street, #building_name, #phone_optional").blur(function () {
    $(this).valid();
  });
  $("#card_number, #exp_month, #exp_year, #cvc").blur(function () {
    $(this).valid();
  });
});

$(function () { // 販売利益の計算
  $('.containt__main__container__inner__sell-form__price__box__top__right__input').on('input', function () {
    var data = $('.containt__main__container__inner__sell-form__price__box__top__right__input').val();
    var profit = Math.round(data * 0.9);
    var fee = (data - profit);
    if (data >= 300 && data <= 9999999) {
      $('.containt__main__container__inner__sell-form__price__box__center__right').html(fee.toLocaleString());
      $('.containt__main__container__inner__sell-form__price__box__center__right').prepend('¥');
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html(profit.toLocaleString());
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').prepend('¥');
    } else {
      $('.containt__main__container__inner__sell-form__price__box__center__right').html('-');
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html('-');
    }
  })
})
