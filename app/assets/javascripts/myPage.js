$(window).on('load', function () { // 各ページでのサイドバーのボタン色変え
  if (document.URL.match("card")) {
    $(".mypage-card").css("background-color", "#EEEEEE");
    $(".mypage-card").children().css("color", "#333333");
  } else if (document.URL.match("profile")) {
    $(".mypage-profile").css("background-color", "#EEEEEE");
    $(".mypage-profile").children().css("color", "#333333");
  } else if (document.URL.match("identification")) {
    $(".mypage-identification").css("background-color", "#EEEEEE");
    $(".mypage-identification").children().css("color", "#333333");
  } else if (document.URL.match("logout")) {
    $(".mypage-logout").css("background-color", "#EEEEEE");
    $(".mypage-logout").children().css("color", "#333333");
  } else if (document.URL.match("exhibiting")) {
      $(".mypage-exhibiting").css("background-color", "#EEEEEE");
      $(".mypage-exhibiting").children().css("color", "#333333");
  } else if (document.URL.match("sold")) {
    $(".mypage-sold").css("background-color", "#EEEEEE");
    $(".mypage-sold").children().css("color", "#333333");
  } else {
    $(".mypage-default").css("background-color", "#EEEEEE");
    $(".mypage-default").children().css("color", "#333333");
  }
});

$(function () { // マイページボタンからのメニュー表示・非表示
  $(".header-lower-right-mypage__user").mouseover(
    function () {
      $(".mypage-header-box").css("display", "block");
    }).mouseout(
    function () {
      $(".mypage-header-box").css("display", "none");
    });
  $(".mypage-header-box").mouseover(
    function () {
      $(".mypage-header-box").css("display", "block");
    }).mouseout(
    function () {
      $(".mypage-header-box").css("display", "none");
    });
});

