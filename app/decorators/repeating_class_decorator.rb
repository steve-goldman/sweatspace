class RepeatingClassDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name, to: :class_template

  def display_studio
    studio.name
  end

  def display_number_of_weeks
    number_word object.number_of_weeks, "week"
  end

  def display_day_of_week
    Date::DAYNAMES[day_of_week].pluralize
  end

  def display_num_remaining
    "#{number_word(repeating_class.remaining_classes.length, "week")} remaining"
  end

  private

  def number_word number, word
    "#{number} #{word.pluralize(number)}"
  end
end
