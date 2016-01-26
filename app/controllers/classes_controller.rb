class ClassesController < ApplicationController
  DEFAULT_RANGE_SPAN = 7

  def index
    @classes_by_date = classes_by_date
    @date_range = date_range
    @presenter = InstructorClassesPresenter.new classes_by_date, date_range
  end

  private

  def classes_by_date
    @classes_by_date ||=
      begin
        classes.each_with_object({}) do |clazz, classes_by_date|
          (classes_by_date[clazz.date] ||= []).push clazz
        end
      end
  end

  def classes
    @classes ||= current_user.instructor_profile.classes.confirmed
      .order(timestamp: :asc)
      .where(timestamp: date_range.range).decorate
  end

  def date_range
    @date_range ||= DateRange.new DEFAULT_RANGE_SPAN, current_user, params[:min_date], params[:max_date]
  end
end
