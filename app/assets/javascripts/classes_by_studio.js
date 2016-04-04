function ClassesByStudio() {
  var $studio = $("#studio-select");
  var $class_templates = $("#class-template-select");
  var $duration = $("#duration-text");

  getClassTemplates = function() {
    return $.ajax({
      url: "/class_templates_by_studio",
      type: "GET",
      dataType: "script",
      data: { studio_id: $studio.val() }
    });
  };

  disableClassTemplates = function() {
    $class_templates.empty();
    $class_templates.attr("disabled", true);
  }

  getDuration = function() {
    return $.ajax({
      url: "/duration_by_class_template",
      type: "GET",
      dataType: "script",
      data: { class_template_id: $class_templates.val() }
    });
  }

  disableDuration = function() {
    $duration.val("");
    $duration.attr("disabled", true);
  }

  $studio.change(function() {
    if ($studio.val() !== "") {
      disableDuration();
      getClassTemplates();
    } else {
      disableClassTemplates();
      disableDuration();
    }
  });

  $class_templates.change(function() {
    if ($class_templates.val() !== "") {
      getDuration();
    } else {
      disableDuration();
    }
  });
}
