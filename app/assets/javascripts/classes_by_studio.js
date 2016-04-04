function ClassesByStudio() {
  var $studio = $("#studio-select");
  var $class_templates = $("#class-template-select");

  getClassTemplates = function() {
    return $.ajax({
      url: "/class_templates_by_studio",
      type: "GET",
      dataType: "script",
      data: { studio_id: $studio.val() }
    });
  };

  $studio.change(function() {
    if ($studio.val() !== "") {
      getClassTemplates();
    } else {
      $class_templates.attr("disabled", true);
    }
  });
}
