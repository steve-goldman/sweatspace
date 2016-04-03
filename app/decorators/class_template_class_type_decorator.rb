class ClassTemplateClassTypeDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template

  def clazz_type_name
    clazz_type.name
  end

  def class_template_name
    class_template.name
  end
end
