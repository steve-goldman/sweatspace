class ClazzDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name,
           :description,
           :display_clazz_types,
           :studio_brand,
           to: :class_template
  decorates_association :instructor_profile
  decorates_association :recurring_class
  decorates_association :studio
  delegate :display_num_remaining, to: :recurring_class

  def display_duration
    "#{object.duration} minutes"
  end

  def display_day_of_week
    object.class_timestamp.try :strftime, "%a"
  end

  def display_date
    object.class_timestamp.try :strftime, "%b %-d"
  end

  def display_long_date
    "#{display_day_of_week} #{display_date}"
  end

  def display_time
    object.class_timestamp.try :strftime, "%l:%M %p"
  end

  def studio_name
    studio.name
  end

  def studio_site
    studio.site
  end

  def studio_full_name
    studio.full_name
  end

  def studio_url
    studio_brand.url
  end
end
