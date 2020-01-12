

$(function() { // 販売利益の計算
  alert("profit ok");
  $('#caliculate').on('input', function () {
    var data = $('#caliculate').val();
    console.log(data);
    var profit = Math.round(data * 0.9);
    console.log(profit);
    var fee = (data - profit);
    console.log(fee);
    if (data >= 300 && data <= 9999999) {
      $('.containt__main__container__inner__sell-form__price__box__center__right').html(fee.toLocaleString());
      $('.containt__main__container__inner__sell-form__price__box__center__right').prepend('¥');
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html(profit.toLocaleString());
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').prepend('¥');
    } else {
      $('.containt__main__container__inner__sell-form__price__box__center__right').html('-');
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html('-');
    }
  });
});
