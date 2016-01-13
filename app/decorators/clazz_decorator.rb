class ClazzDecorator < Draper::Decorator
  delegate_all

  def display_time
    object.time.strftime "%b %d %l:%M %p"
  end
end
