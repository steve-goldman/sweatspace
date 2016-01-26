module ClassTemplatesHelper
  def class_template_options
    make_class_template_options all_class_templates
  end

  def not_studio_class_template_options studio
    make_class_template_options(all_class_templates - studio.class_templates)
  end

  def class_template_studio_options studio
    make_class_template_options studio.class_templates
  end

  def not_clazz_type_class_template_options clazz_type
    make_class_template_options(all_class_templates - clazz_type.class_templates)
  end

  def class_template_clazz_type_options clazz_type
    make_class_template_options clazz_type.class_templates
  end

  private

  def all_class_templates
    ClassTemplate.all.order name: :asc
  end

  def make_class_template_options class_templates
    class_templates.map do |class_template|
      [class_template.name, class_template.id]
    end
  end
end
