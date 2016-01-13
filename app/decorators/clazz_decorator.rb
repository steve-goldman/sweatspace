class ClazzDecorator < Draper::Decorator
  delegate_all

  def display_time
    object.time.strftime "%b %d %l:%M %p"
  end

  def display_duration
    "#{object.duration} minutes"
  end

  def display_studio
    studio.name
  end

  def studio_url
    studio.url
  end
end
