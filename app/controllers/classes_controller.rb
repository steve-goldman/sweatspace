class ClassesController < ApplicationController
  DATE_RANGE_SPAN = 7

  def index
    @clazzes = current_user.instructor_profile.classes.confirmed
      .order(timestamp: :asc)
      .where(timestamp: min_date..max_date).decorate
    @prev_min_date = prev_min_date
    @prev_max_date = prev_max_date
    @next_min_date = next_min_date
    @next_max_date = next_max_date
  end

  private

  def min_date
    @min_date ||= param_date("min_date") || current_user.today
  end

  def max_date
    @max_date ||= (param_date("max_date") || current_user.today + DATE_RANGE_SPAN.days) + 1.day - 1.second
  end

  def param_date key
    begin
      Date.parse(params[key]).in_time_zone(current_user.timezone)
    rescue
      nil
    end
  end

  def formatted_date time
    time.strftime "%Y-%m-%d"
  end

  def prev_min_date
    formatted_date(min_date - DATE_RANGE_SPAN.days)
  end

  def prev_max_date
    formatted_date(min_date - 1.day)
  end

  def next_min_date
    formatted_date(max_date + 1.day)
  end

  def next_max_date
    formatted_date(max_date + DATE_RANGE_SPAN.days)
  end
end
