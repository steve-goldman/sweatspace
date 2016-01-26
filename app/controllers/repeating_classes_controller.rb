class RepeatingClassesController < ApplicationController
  def index
    @repeating_classes_by_day = repeating_classes_by_day
  end

  private

  def repeating_classes_by_day
    repeating_classes.each_with_object({}) do |repeating_class, repeating_classes_by_day|
      (repeating_classes_by_day[repeating_class.day_of_week] ||= []).push repeating_class
    end
  end

  def repeating_classes
    @repeating_classes ||= current_user.instructor_profile.repeating_classes.confirmed
      .order(day_of_week: :asc).decorate
  end
end
