function SubmitOnChange() {
  $(".submit-on-change").change(function() {
    $("input[type='submit']").prop("disabled", true);
    $("form").submit();
  });
};
