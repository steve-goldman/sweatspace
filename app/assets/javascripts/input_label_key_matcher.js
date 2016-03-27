function InputLabelKeyMatcher(input_selector, label_selector) {
  var $input = $(input_selector);
  var $label = $(label_selector);
  var label_stem = $label.html();

  function setLabel(input_text) {
    $label.html(label_stem + input_text);
  };
  $input.keyup(function(event) {
    setLabel(event.target.value);
  });
  var initial_input_text = $input.attr("value") || "";
  setLabel(initial_input_text);
}
