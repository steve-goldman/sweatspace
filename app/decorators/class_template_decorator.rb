class ClassTemplateDecorator < Draper::Decorator
  delegate_all

  def display_duration
    "#{object.duration} minutes"
  end

  def display_clazz_types
    object.clazz_types.map(&:name).join(", ")
  end
end
