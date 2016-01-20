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

  def display_date
    in_time_zone.strftime "%b %d"
  end

  def display_time
    in_time_zone.strftime "%l:%M %p"
  end

  private

  def in_time_zone
    @in_time_zone ||= object.timestamp.in_time_zone(object.class_template.studio.timezone)
  end
end
