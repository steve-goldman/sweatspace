class RepeatingClassesController < ApplicationController
  def index
    @repeating_classes = current_user.instructor_profile.repeating_classes.confirmed.decorate
  end
end
