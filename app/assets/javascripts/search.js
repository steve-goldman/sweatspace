$(document).ready(function() {
  var $primaryNav = $("#primary-nav");
  var $narrowSearchText = $("#narrow-search-text");
  var $searchNav = $("#search-nav");
  var $searchText = $("#search-text");
  var $searchBackLink = $("#search-back-link");
  var $searchPopout = $("#search-popout");
  var $body = $("#body");

  var dismissSearch = function() {
    $body.fadeTo(500, 1.0);
    $searchNav.hide();
    $primaryNav.show();
  };

  var showSearch = function() {
    $body.on("click", function(e) {
      e.preventDefault();
      $body.off("click");
      dismissSearch();
      return false;
    });
    $body.fadeTo(500, 0.5);
    $primaryNav.hide();
    $searchNav.show();
    if ($searchText.val().trim() === "") {
      $searchPopout.hide();
    }
    $searchText.focus();
  };

  $searchText.keyup(function() {
    if ($searchText.val().trim() === "") {
      $searchPopout.hide();
    } else {
      $searchPopout.show();
      return $.ajax({
        url: "/search",
        type: "GET",
        dataType: "script",
        data: { query: $searchText.val() }
      });
    }
  });

  $narrowSearchText.click(showSearch);

  $searchBackLink.click(dismissSearch);

  $searchNav.hide();
});
