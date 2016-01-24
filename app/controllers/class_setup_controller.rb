class ClassSetupController < ApplicationController
  before_action :find_clazz, except: :new
  before_action :owns_clazz, except: :new

  include Wicked::Wizard
  steps :class_template, :studio, :date, :time, :confirm

  def show
    @clazz = @clazz.decorate
    render_wizard
  end

  def update
    @clazz.update_attributes update_params
    render_wizard @clazz
  end

  def new
    @clazz = current_user.instructor_profile.classes.create
    redirect_to wizard_path steps.first, class_id: @clazz.id
  end

  def finish_wizard_path
    classes_path
  end

  private

  def find_clazz
    @clazz = Clazz.find_by id: params[:class_id]
    if @clazz.nil?
      flash[:danger] = "Could not find class"
      redirect_to classes_path
    end
  end

  def owns_clazz
    unless current_user.id == @clazz.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def update_params
    params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
  end
end
