$(function(){
  var array1 = ['未定','らくらくメルカリ便','ゆうメール','レターパック','普通郵便（定型、定型外）',
                'クロネコヤマト','ゆうパック','クリックポスト','ゆうパケット']
  var array2 = ['未定','クロネコヤマト','ゆうパック','ゆうメール']

  function appendOption(method){
    var html = `<option value="${method}">${method}</option>`;
    return html;
  }
  $(window).on('load',function(){ // 現在のページロードした時の処理
    // パスの取得
    var path = location.pathname

    if (path == "/products/new") { // 新規出品時
    $("#product_delivery_cost").on('change',function(){
      var delivery_parentCategory = ""
      delivery_parentCategory = document.getElementById('product_delivery_cost').value;
      if (delivery_parentCategory != "---"){
        $.ajax({
          url: 'delivery_way',
          type: 'GET',
          data: { parent_name: delivery_parentCategory },
          dataType: 'json'
        })
        .done(function() {
          $('#delivery_way-parent').remove();
          var methodBoxHtml = '';
          var insertHTML = '';
          if (delivery_parentCategory == "1"){
            array1.forEach(function(method){
            insertHTML += appendOption(method);
            });
          } else {
              array2.forEach(function(method){
              insertHTML += appendOption(method);
              });
            }
          methodBoxHtml = `<div class="containt__main__container__inner__sell-form__delivery__box__form-group__added" id="delivery_way-parent"> 
                            <label>配送の方法</label> 
                              <span class='containt__main__container__inner__sell-form__form-require'>必須</span> 
                            <div class='containt__main__container__inner__sell-form__delivery__box__select-wrap'></div>
                              <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__delivery__box__select-wrap__icon'></i>
                              <select class="containt__main__container__inner__sell-form__delivery__box__select-wrap__list" id="delivery_way" name="product[delivery_way]">
                                <option value="">---</option>
                                ${insertHTML}
                              </select>
                            </div>
                          </div>`;
          $('.containt__main__container__inner__sell-form__delivery__box__form-group__cost').append(methodBoxHtml);
          $('#delivery_way').blur(function () {
            $(this).valid();
          });
        })
      }
      else {$('#delivery_way-parent').remove();}
    });

    } else if (path == "/products") {

      $("#product_delivery_cost").on('change',function(){
        var delivery_parentCategory = ""
        delivery_parentCategory = document.getElementById('product_delivery_cost').value;
        if (delivery_parentCategory != "---"){
          $.ajax({
            url: 'products/delivery_way',
            type: 'GET',
            data: { parent_name: delivery_parentCategory },
            dataType: 'json'
          })
          .done(function() {
            $('#delivery_way-parent').remove();
            var methodBoxHtml = '';
            var insertHTML = '';
            if (delivery_parentCategory == "1"){
              array1.forEach(function(method){
              insertHTML += appendOption(method);
              });
            } else {
                array2.forEach(function(method){
                insertHTML += appendOption(method);
                });
              }
            methodBoxHtml = `<div class="containt__main__container__inner__sell-form__delivery__box__form-group__added" id="delivery_way-parent"> 
                              <label>配送の方法</label> 
                                <span class='containt__main__container__inner__sell-form__form-require'>必須</span> 
                              <div class='containt__main__container__inner__sell-form__delivery__box__select-wrap'></div>
                                <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__delivery__box__select-wrap__icon'></i>
                                <select class="containt__main__container__inner__sell-form__delivery__box__select-wrap__list" id="delivery_way" name="product[delivery_way]">
                                  <option value="">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
            $('.containt__main__container__inner__sell-form__delivery__box__form-group__cost').append(methodBoxHtml);
            $('#delivery_way').blur(function () {
              $(this).valid();
            });
          })
        }
        else {$('#delivery_way-parent').remove();}
      });
    }
  });
});
