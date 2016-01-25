class RepeatingClassSetupController < ApplicationController
  before_action :find_clazz, only: :start
  before_action :find_repeating_class, except: [:start, :finish]
  before_action :owns_repeating_class, except: [:start, :finish]

  include Wicked::Wizard
  steps :forever, :number_of_weeks, :confirm

  def show
    if step == :number_of_weeks && @repeating_class.forever?
      skip_step
    end
    @repeating_class = @repeating_class.decorate
    render_wizard
  end

  def update
    @repeating_class.update_attributes update_params
    if @repeating_class.valid? && @repeating_class.confirmed?
      @repeating_class.create_classes!
    end
    render_wizard @repeating_class
  end

  def start
    @clazz.make_into_repeating_class!
    redirect_to wizard_path steps.first, repeating_class_id: @clazz.repeating_class.id
  end

  def finish
    flash[:success] = "Repeating class created"
    redirect_to classes_path
  end

  def finish_wizard_path
    finish_repeating_setup_repeating_classes_path
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
    @repeating_class = scope.find_by id: params[:repeating_class_id]
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

  def scope
    # TODO: deficiency in wicked that 'step' method not available to before_action methods?
    if params[:id].to_sym == :wicked_finish
      RepeatingClass.confirmed
    else
      RepeatingClass.unconfirmed
    end
  end
end
