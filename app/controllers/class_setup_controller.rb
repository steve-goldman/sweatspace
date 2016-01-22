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
    merge_with_timestamps params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
  end

  def merge_with_timestamps safe_params
    if step == :date
      safe_params.merge(timestamp: TimeService.instance.timestamp(params[:clazz][:class_date], "12:00 PM", timezone))
    elsif step == :time
      safe_params.merge(timestamp: TimeService.instance.timestamp(TimeService.instance.date(@clazz.timestamp, timezone), params[:clazz][:class_time], timezone))
    else
      safe_params
    end
  end

  def timezone
    @clazz.studio.timezone
  end
end
