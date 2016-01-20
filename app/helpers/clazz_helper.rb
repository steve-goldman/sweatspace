module ClazzHelper
  def class_template_options
    current_user.instructor_profile.class_templates.map do |class_template|
      [class_template.name, class_template.id]
    end
  end
end
