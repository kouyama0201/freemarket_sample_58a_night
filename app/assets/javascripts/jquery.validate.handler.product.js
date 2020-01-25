$(function () {
  // メソッドの定義
  var methods = {
    price: function (value, element) {
      return this.optional(element) || /^\d+$/.test(value);
    },
  }
  // メソッドの追加
  $.each(methods, function (key) {
    $.validator.addMethod(key, this);
  });
  // バリデーションの実行
  $("#product-form").validate({
    // ルール設定
    rules: {
      "product[name]": {
        required: true,
        rangelength: [1, 40]
      },
      "product[description]": {
        required: true,
        rangelength: [1, 1000]
      },
      "product[category_id]": {
        required: true
      },
      "parent": {
        required: true
      },
      "child": {
        required: true
      },
      "parent": {
        required: true,
      },
      "child": {
        required: true,
      },
      "product[size_id]": {
        required: true
      },
      "product[condition]": {
        required: true
      },
      "product[delivery_cost]": {
        required: true
      },
      "product[delivery_way]": {
        required: true
      },
      "product[delivery_origin]": {
        required: true
      },
      "product[preparatory_days]": {
        required: true
      },
      "product[price]": {
        required: true,
        price: true,
        range: [300, 9999999]
      },
    },
    // エラーメッセージの定義
    messages: {
      "product[name]": {
        required: "入力してください",
        rangelength: "40文字以内で入力してください"
      },
      "product[description]": {
        required: "入力してください",
        rangelength: "1000文字以内で入力してください"
      },
      "product[category_id]": {
        required: "選択してください"
      },
      "parent": {
        required: "選択してください"
      },
      "child": {
        required: "選択してください"
      },
      "parent": {
        required: "選択してください",
      },
      "child": {
        required: "選択してください",
      },
      "product[size_id]": {
        required: "選択してください"
      },
      "product[condition]": {
        required: "選択してください"
      },
      "product[delivery_cost]": {
        required: "選択してください"
      },
      "product[delivery_way]": {
        required: "選択してください"
      },
      "product[delivery_origin]": {
        required: "選択してください"
      },
      "product[preparatory_days]": {
        required: "選択してください"
      },
      "product[price]": {
        required: "300以上9999999以下で入力してください",
        price: "半角数字で入力してください",
        range: "300以上9999999以下で入力してください"
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
  });
  // 入力欄or選択欄をフォーカスアウトしたときにバリデーションを実行
  $("#product_name, #description, #parent_category, #child_category, #grandchild_category, #size, #product_condition, #product_delivery_cost, #delivery_way, #product_delivery_origin, #product_preparatory_days, #price").blur(function () {
    $(this).valid();
  });
});