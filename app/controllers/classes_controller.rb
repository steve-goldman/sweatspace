class ClassesController < ApplicationController
  DEFAULT_RANGE_SPAN = 7

  def index
    @clazzes = current_user.instructor_profile.classes.confirmed
      .order(timestamp: :asc)
      .where(timestamp: date_range.range).decorate
    @min_date = date_range.min_date
    @max_date = date_range.max_date
    @prev_min_date = date_range.prev_min_date
    @prev_max_date = date_range.prev_max_date
    @next_min_date = date_range.next_min_date
    @next_max_date = date_range.next_max_date
  end

  private

  def date_range
    @date_range ||= DateRange.new DEFAULT_RANGE_SPAN, current_user, params[:min_date], params[:max_date]
  end
end
