$(function(){
  $('.containt__main__container__inner__sell-form__price__box__top__right__input').on('keydown keyup keypress', function () {
    var data = $('.containt__main__container__inner__sell-form__price__box__top__right__input').val();
    var profit = Math.round(data * 0.9)
    var fee = (data - profit)
    if (data >= 300 && data <= 9999999){
      $('.containt__main__container__inner__sell-form__price__box__center__right').html(fee.toLocaleString())
      $('.containt__main__container__inner__sell-form__price__box__center__right').prepend('¥')
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html(profit.toLocaleString())
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').prepend('¥')
    }
    else {
      $('.containt__main__container__inner__sell-form__price__box__center__right').html('-');
      $('.containt__main__container__inner__sell-form__price__box__bottom__right').html('-');
    }
  })
})
