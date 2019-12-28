$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='containt__main__container__inner__sell-form__detail__box__form-group__added' id= 'child_wrapper'>
                        <div class='containt__main__container__inner__sell-form__select-wrap'>
                          <select class="containt__main__container__inner__sell-form__select-wrap__list" id="child_category" name="category_id">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                          <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__select-wrap__icon'></i>
                        </div>
                      </div>`;
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchildBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='containt__main__container__inner__sell-form__detail__box__form-group__added' id= 'grandchild_wrapper'>
                              <div class='containt__main__container__inner__sell-form__select-wrap'>
                                <select class="containt__main__container__inner__sell-form__select-wrap__list" id="grandchild_category" name="category_id">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__select-wrap__icon'></i>
                              </div>
                            </div>`;
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'category_child',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_wrapper').remove(); //親が変更された時、子以下を削除するする
        $('#grandchild_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchild_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.containt__main__container__inner__sell-form__detail__box__form-group__category').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'category_grandchild',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_wrapper').remove(); //子が変更された時、孫以下を削除するする
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
});