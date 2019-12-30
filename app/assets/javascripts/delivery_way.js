$(function(){
  var array1 = ['未定','らくらくメルカリ便','ゆうメール','レターパック','普通郵便（定型、定型外）',
                'クロネコヤマト','ゆうパック','クリックポスト','ゆうパケット']
  var array2 = ['未定','クロネコヤマト','ゆうパック','ゆうメール']

  function appendOption(method){
    var html = `<option value="${method}">${method}</option>`;
    return html;
  }

  $("#delivery_cost").on('change',function(){
    var delivery_parentCategory = ""
    delivery_parentCategory = document.getElementById('delivery_cost').value;
    if (delivery_parentCategory != "---"){
      $.ajax({
        url: 'delivery_way',
        type: 'GET',
        data: { parent_name: delivery_parentCategory },
        dataType: 'json'
      })
      .done(function() {
        $('#delivery_method-parent').remove();
        var methodBoxHtml = '';
        var insertHTML = '';
        if (delivery_parentCategory == "送料込み（出品者負担）"){
          array1.forEach(function(method){
          insertHTML += appendOption(method);
          });
        } else {
            array2.forEach(function(method){
            insertHTML += appendOption(method);
            });
          }
        methodBoxHtml = `<div class="containt__main__container__inner__sell-form__delivery__box__form-group__added" id="delivery_method-parent"> 
                          <label>配送の方法</label> 
                            <span class='containt__main__container__inner__sell-form__form-require'>必須</span> 
                          <div class='containt__main__container__inner__sell-form__delivery__box__select-wrap'></div>
                            <select class="containt__main__container__inner__sell-form__delivery__box__select-wrap__list" id="delivery_cost">
                              <option value="---">---</option>
                              ${insertHTML}
                            </select>
                            <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__delivery__box__select-wrap__icon'></i>
                          </div>
                        </div>`;
      $('.containt__main__container__inner__sell-form__delivery__box__form-group__cost').append(methodBoxHtml);
      })
    }
    else {$('#delivery_method-parent').remove();}
  });
});
