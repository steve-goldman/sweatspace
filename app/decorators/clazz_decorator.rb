class ClazzDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name,
           :description,
           :display_duration,
           :display_clazz_type,
           to: :class_template

  def display_date
    in_time_zone.strftime "%b %d"
  end

  def display_time
    in_time_zone.strftime "%l:%M %p"
  end

  def display_studio
    studio.name
  end

  def studio_url
    studio.url
  end

  private

  def in_time_zone
    @in_time_zone ||= object.timestamp.in_time_zone(object.studio.timezone)
  end
end
