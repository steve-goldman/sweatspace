class RecurringClassDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template
  delegate :name, to: :class_template

  def display_studio
    studio.name
  end

  def display_number_of_weeks
    if number_of_weeks
      if open_ended?
        "Open ended"
      else
        number_word number_of_weeks, "week"
      end
    end
  end

  def display_first_date
    unless first_date.blank?
      Date.parse(first_date).try :strftime, "%b %-d %Y"
    end
  end

  def display_day_of_week
    if day_of_week
      Date::DAYNAMES[day_of_week].pluralize
    end
  end

  def display_time
    if time_of_day.try :start_with?, "0"
      time_of_day[1..-1]
    else
      time_of_day
    end
  end

  def display_num_remaining
    "#{remaining_classes.length} remaining"
  end

  private

  def number_word number, word
    "#{number} #{word.pluralize(number)}"
  end
end
