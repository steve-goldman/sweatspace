class ClassTemplateDecorator < Draper::Decorator
  delegate_all

  def display_duration
    "#{object.duration} minutes"
  end

  def display_clazz_type
    object.clazz_type.name
  end
end
