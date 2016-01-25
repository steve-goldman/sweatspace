class RepeatingClassDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name, to: :class_template

  def display_studio
    studio.name
  end

  def display_number_of_weeks
    "#{object.number_of_weeks} #{'week'.pluralize(object.number_of_weeks)}"
  end
end
