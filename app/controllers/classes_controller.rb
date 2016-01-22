class ClassesController < ApplicationController
  def index
    @clazzes = profile.classes.confirmed.order(timestamp: :asc).where(timestamp: 1.day.ago..30.days.from_now).decorate
  end

  def new
    @clazz = Clazz.new
  end

  def create
    @clazz = profile.classes.build create_params
    if @clazz.save
      flash[:success] = "Class created"
      redirect_to classes_path
    else
      flash[:danger] = "Unable to create class"
      render :new
    end
  end

  private

  def create_params
    params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
      .merge(timestamp: timestamp)
  end

  def profile
    current_user.instructor_profile
  end
end
