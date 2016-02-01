class ClazzDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name,
           :description,
           :display_duration,
           :display_clazz_type,
           to: :class_template
  decorates_association :repeating_class
  delegate :display_num_remaining, to: :repeating_class

  def display_day_of_week
    object.class_timestamp.try :strftime, "%a"
  end

  def display_date
    object.class_timestamp.try :strftime, "%b %d"
  end

  def display_long_date
    "#{display_day_of_week} #{display_date}"
  end

  def display_time
    object.class_timestamp.try :strftime, "%l:%M %p"
  end

  def display_studio
    studio.name
  end

  def studio_url
    studio.url
  end
end
