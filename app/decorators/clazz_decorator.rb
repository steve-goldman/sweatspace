class ClazzDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name,
           :description,
           :display_duration,
           :display_clazz_type,
           :display_studio,
           :studio_url,
           to: :class_template

  def display_time
    object.time.strftime "%b %d %l:%M %p"
  end
end
