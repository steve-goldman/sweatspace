class InstructorClassesPresenter
  attr_reader :classes_by_date, :date_range

  def initialize classes_by_date, date_range
    @classes_by_date = classes_by_date
    @date_range = date_range
  end

  def count_message
    [classes_count,
     "class".pluralize(classes_count),
     "from",
     count_message_date(date_range.start_date),
     "to",
     count_message_date(date_range.end_date)
    ].join(" ")
  end

  def header_display_date date
    Date.parse(date).strftime "%A, %b. %e"
  end

  private

  def classes_count
    @classes_count ||= classes_by_date.values.map(&:count).reduce(0, :+)
  end

  def count_message_date date
    date.strftime "%b. %e"
  end
end
