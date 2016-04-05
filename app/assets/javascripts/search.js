$(document).ready(function() {
  var $primaryNav = $("#primary-nav");
  var $narrowSearchText = $("#narrow-search-text");
  var $searchNav = $("#search-nav");
  var $searchText = $("#search-text");
  var $searchBackLink = $("#search-back-link");
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
    });
    $body.fadeTo(500, 0.5);
    $primaryNav.hide();
    $searchNav.show();
    $searchText.focus();
  };

  $narrowSearchText.click(showSearch);

  $searchBackLink.click(dismissSearch);

  $searchNav.hide();
});
