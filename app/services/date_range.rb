class DateRange
  DEFAULT_RANGE_SPAN = 7
  DEFAULT_NUM_PAGES = 4

  attr_reader :user, :span, :num_pages

  def initialize user, start_date, options = nil
    options ||= {}
    @user = user
    @param_start_date = start_date
    @span = options[:span] || DEFAULT_RANGE_SPAN
    @num_pages = options[:num_pages] || DEFAULT_NUM_PAGES
  end

  def range
    start_date..end_date
  end

  def start_date
    @start_date ||=
      if @param_start_date
        bounded_start_date param_date(@param_start_date)
      else
        today
      end
  end

  def end_date
    @end_date ||=
      bounded_end_date start_date + span.days - 1.second
  end

  def has_prev?
    @has_prev ||=
      bounded_start_date(start_date - 1.second) != start_date
  end

  def prev_start_date
    @prev_start_date ||=
      formatted_date bounded_start_date(start_date - span.days)
  end

  def has_next?
    @has_next ||=
      bounded_end_date(end_date + 1.second) != end_date
  end

  def next_start_date
    @next_start_date ||=
      formatted_date bounded_start_date(start_date + span.days)
  end

  private

  def param_date date
    begin
      Date.parse(date).in_time_zone(timezone)
    rescue
      nil
    end
  end

  def formatted_date time
    time.strftime "%Y-%m-%d"
  end

  def bounded_start_date date
    bounded_date date, today, today + (span * num_pages - 1).days
  end

  def bounded_end_date date
    bounded_date date, today + span.days - 1.second, today + (span * num_pages).days - 1.second
  end

  def bounded_date date, floor, ceiling
    if date < floor
      floor
    elsif date > ceiling
      ceiling
    else
      date
    end
  end

  def today
    user ? user.today : Time.now.midnight
  end

  def timezone
    user ? user.timezone : "Eastern Time (US & Canada)"
  end
end
