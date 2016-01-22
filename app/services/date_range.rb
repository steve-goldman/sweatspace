class DateRange
  def initialize span, user, min_date, max_date
    @span = span
    @user = user
    @param_min_date = min_date
    @param_max_date = max_date
  end

  def range
    min_date..max_date
  end

  def min_date
    @min_date ||= param_date(@param_min_date) || @user.today
  end

  def max_date
    @max_date ||= (param_date(@param_max_date) || @user.today + @span.days) + 1.day - 1.second
  end

  def prev_min_date
    formatted_date(min_date - @span.days)
  end

  def prev_max_date
    formatted_date(min_date - 1.day)
  end

  def next_min_date
    formatted_date(max_date + 1.day)
  end

  def next_max_date
    formatted_date(max_date + @span.days)
  end

  private

  def param_date date
    begin
      Date.parse(date).in_time_zone(@user.timezone)
    rescue
      nil
    end
  end

    def formatted_date time
    time.strftime "%Y-%m-%d"
  end
end
