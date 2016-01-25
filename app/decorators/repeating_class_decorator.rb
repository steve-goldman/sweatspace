class RepeatingClassDecorator < Draper::Decorator
  delegate_all

  def display_number_of_weeks
    "#{object.number_of_weeks} #{'week'.pluralize(object.number_of_weeks)}"
  end
end
