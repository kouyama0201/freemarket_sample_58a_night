$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // サイズセレクトボックスのオプションを作成
  function appendSizeOption(size){
    var html = `<option value="${size.id}">${size.size}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='containt__main__container__inner__sell-form__detail__box__form-group__added' id= 'child_wrapper'>
                        <div class='containt__main__container__inner__sell-form__select-wrap'>
                          <select class="containt__main__container__inner__sell-form__select-wrap__list" id="child_category" name="child">
                            <option value="" data-category="---">---</option>
                            ${insertHTML}
                          </select>
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
                                <select class="containt__main__container__inner__sell-form__select-wrap__list" id="grandchild_category" name="product[category_id]">
                                  <option value="" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__select-wrap__icon'></i>
                              </div>
                            </div>`;
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').append(grandchildSelectHtml);
  }
  // サイズ・ブランド入力欄の表示作成
  function appendSizeBox(insertHTML){
    var sizeSelectHtml = '';
    sizeSelectHtml = `<div class="containt__main__container__inner__sell-form__detail__box__form-group__size" id= 'size_wrapper'>
                        <label>サイズ</label>
                        <span class='containt__main__container__inner__sell-form__form-require'>必須</span>
                          <div class='containt__main__container__inner__sell-form__select-wrap'>
                            <select class="containt__main__container__inner__sell-form__select-wrap__list" id="size" name="product[size_id]">
                              <option value="">---</option>
                              ${insertHTML}
                            </select>
                            <i class='fas fa-chevron-down fa-lg containt__main__container__inner__sell-form__select-wrap__icon'></i>
                          </div>
                      </div>
                      <div class="containt__main__container__inner__sell-form__detail__box__form-group__brand" id="brand_wrapper">
                        <label>ブランド</label>
                          <span class='containt__main__container__inner__sell-form__form-optional'>任意</span>
                          <input class="containt__main__container__inner__sell-form__select-wrap__brand" placeholder="例) シャネル" type="text" name="product[brand]">
                      </div>`;
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').append(sizeSelectHtml);
  }
  // ブランド入力欄のみの表示作成
  function appendBrandBox(){
    brandInputHtml = `<div class="containt__main__container__inner__sell-form__detail__box__form-group__brand" id="brand_wrapper">
                        <label>ブランド</label>
                          <span class='containt__main__container__inner__sell-form__form-optional'>任意</span>
                          <input class="containt__main__container__inner__sell-form__select-wrap__brand" placeholder="例) シャネル" type="text" name="product[brand]">
                      </div>`;
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').append(brandInputHtml);
  }
  // 親カテゴリー選択後のイベント

  $(window).on('load',function(){ // 現在のページロードした時の処理
    // パスの取得
    var path = location.pathname

    if (path == "/products/new") { // 新規出品時
    $('#parent_category').on('change', function(){
      var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
      if (parentCategory != ""){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'category_child',
          type: 'GET',
          data: { parent_name: parentCategory },
          dataType: 'json'
        })
        .done(function(children){
          $('#child_wrapper').remove(); //親が変更された時、子以下を削除する
          $('#grandchild_wrapper').remove();
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChildBox(insertHTML);
          $("#child_category").blur(function () {
            $(this).valid();
          });
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      } else {
        $('#child_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
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
            $('#grandchild_wrapper').remove(); //子が変更された時、孫以下を削除する
            $('#size_wrapper').remove();
            $('#brand_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildBox(insertHTML);
            $("#grandchild_category").blur(function () {
              $(this).valid();
            });
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      } else {
        $('#grandchild_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
      }
    });
    $('.containt__main__container__inner__sell-form__detail__box__form-group__category').on('change', '#grandchild_category', function(){
      var grandchildId = $('#grandchild_category option:selected').data('category'); //選択された孫カテゴリーのidを取得
      if (grandchildId != "---"){ //孫カテゴリーが初期値でないことを確認
        $.ajax({
          url: 'size',
          type: 'GET',
          data: { grandchild_id: grandchildId },
          dataType: 'json'
        })
        .done(function(sizes){
          $('#size_wrapper').remove(); //孫が変更された時、サイズ欄以下を削除する
          $('#brand_wrapper').remove();
          if (sizes.length != 0) {
          var insertHTML = '';
            sizes.forEach(function(size){
              insertHTML += appendSizeOption(size);
            });
            appendSizeBox(insertHTML);
            $("#size").blur(function () {
              $(this).valid();
            });
          } else {
            appendBrandBox(); // 紐付くサイズがない場合には、ブランド入力欄のみ生成する
          }
        })
        .fail(function(){
          alert('サイズ取得に失敗しました');
        })
      } else {
        $('#size_wrapper').remove(); //孫カテゴリーが初期値になった時、サイズ欄以下を削除する
        $('#brand_wrapper').remove();
      }
    });

    } else if (path == "/products") { // 新規でエラー発生で再出品する場合

      $('#parent_category').on('change', function(){
        var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
        if (parentCategory != ""){ //親カテゴリーが初期値でないことを確認
          $.ajax({
            url: '/products/category_child',
            type: 'GET',
            data: { parent_name: parentCategory },
            dataType: 'json'
          })
          .done(function(children){
            $('#child_wrapper').remove(); //親が変更された時、子以下を削除する
            $('#grandchild_wrapper').remove();
            $('#size_wrapper').remove();
            $('#brand_wrapper').remove();
            var insertHTML = '';
            children.forEach(function(child){
              insertHTML += appendOption(child);
            });
            appendChildBox(insertHTML);
            $("#child_category").blur(function () {
              $(this).valid();
            });
          })
          .fail(function(){
            alert('カテゴリー取得に失敗しました');
          })
        } else {
          $('#child_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
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
            url: '/products/category_grandchild',
            type: 'GET',
            data: { child_id: childId },
            dataType: 'json'
          })
          .done(function(grandchildren){
            if (grandchildren.length != 0) {
              $('#grandchild_wrapper').remove(); //子が変更された時、孫以下を削除する
              $('#size_wrapper').remove();
              $('#brand_wrapper').remove();
              var insertHTML = '';
              grandchildren.forEach(function(grandchild){
                insertHTML += appendOption(grandchild);
              });
              appendGrandchildBox(insertHTML);
              $("#grandchild_category").blur(function () {
                $(this).valid();
              });
            }
          })
          .fail(function(){
            alert('カテゴリー取得に失敗しました');
          })
        } else {
          $('#grandchild_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
        }
      });
      $('.containt__main__container__inner__sell-form__detail__box__form-group__category').on('change', '#grandchild_category', function(){
        var grandchildId = $('#grandchild_category option:selected').data('category'); //選択された孫カテゴリーのidを取得
        if (grandchildId != "---"){ //孫カテゴリーが初期値でないことを確認
          $.ajax({
            url: '/products/size',
            type: 'GET',
            data: { grandchild_id: grandchildId },
            dataType: 'json'
          })
          .done(function(sizes){
            $('#size_wrapper').remove(); //孫が変更された時、サイズ欄以下を削除する
            $('#brand_wrapper').remove();
            if (sizes.length != 0) {
            var insertHTML = '';
              sizes.forEach(function(size){
                insertHTML += appendSizeOption(size);
              });
              appendSizeBox(insertHTML);
              $("#size").blur(function () {
                $(this).valid();
              });
            } else {
              appendBrandBox(); // 紐付くサイズがない場合には、ブランド入力欄のみ生成する
            }
          })
          .fail(function(){
            alert('サイズ取得に失敗しました');
          })
        } else {
          $('#size_wrapper').remove(); //孫カテゴリーが初期値になった時、サイズ欄以下を削除する
          $('#brand_wrapper').remove();
        }
      });
    }
  });
});
