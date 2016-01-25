class RepeatingClassSetupController < ApplicationController
  before_action :find_clazz, except: :finish
  before_action :find_repeating_class, except: [:start, :finish]
  before_action :owns_repeating_class, except: [:start, :finish]

  include Wicked::Wizard
  steps :forever, :number_of_weeks, :confirm

  def show
    if step == :number_of_weeks && @repeating_class.forever?
      skip_step
    end
    @clazz = @clazz.decorate
    @repeating_class = @repeating_class.decorate
    render_wizard
  end

  def update
    @repeating_class.update_attributes update_params
    render_wizard @repeating_class
  end

  def start
    repeating_class = @clazz.make_into_repeating_class!
    redirect_to wizard_path steps.first, class_id: @clazz.id
  end

  def finish
    flash[:success] = "Repeating class created"
    redirect_to classes_path
  end

  def finish_wizard_path
    finish_repeatingsetup_classes_path
  end

  private

  def find_clazz
    @clazz = Clazz.confirmed.find_by id: params[:class_id]
    if @clazz.nil?
      flash[:danger] = "Could not find class"
      redirect_to classes_path
    end
  end

  def find_repeating_class
    @repeating_class = @clazz.repeating_class
    if @repeating_class.nil?
      flash[:danger] = "Could not find repeating class"
      redirect_to classes_path
    end
  end

  def owns_repeating_class
    unless current_user.id == @repeating_class.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def update_params
    params.require(:repeating_class).permit(RepeatingClass::PERMITTED_PARAMS)
  end
end
