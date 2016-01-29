class RepeatingClassDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name, to: :class_template

  def display_studio
    studio.name
  end

  def display_number_of_weeks
    if object.number_of_weeks.present?
      number_word object.number_of_weeks, "week"
    end
  end

  def display_day_of_week
    Date::DAYNAMES[day_of_week].pluralize
  end

  def display_time
    if time_of_day.start_with? "0"
      time_of_day[1..-1]
    else
      time_of_day
    end
  end

  def display_num_remaining
    "#{number_word(repeating_class.remaining_classes.length, "week")} remaining"
  end

  private

  def number_word number, word
    "#{number} #{word.pluralize(number)}"
  end
end
