class InstructorClassesPresenter
  attr_reader :classes_by_date, :date_range

  def initialize classes_by_date, date_range
    @classes_by_date = classes_by_date
    @date_range = date_range
  end

  def count_in_range_display
    "#{classes_count} #{'class'.pluralize(classes_count)} from #{date_range.start_date.to_date} to #{date_range.end_date.to_date}"
  end

  def header_display_date date
    Date.parse(date).strftime("%A, %b. %e, %Y").downcase
  end

  private

  def classes_count
    @classes_count ||= classes_by_date.values.map(&:count).reduce(0, :+)
  end
end
