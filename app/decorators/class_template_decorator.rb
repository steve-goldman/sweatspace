class ClassTemplateDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template_class_types

  def display_duration
    "#{object.duration} minutes"
  end

  def display_clazz_types
    object.clazz_types.map(&:name).join(", ")
  end

  def studio_brand_name
    studio_brand.name
  end

  def clazz_type_name
    clazz_type.name
  end
end
