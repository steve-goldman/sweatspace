class RepeatingClassesController < ApplicationController
  before_action :find_repeating_class, only: [:edit, :update, :confirm, :confirmed]
  before_action :owns_repeating_class, only: [:edit, :update, :confirm, :confirmed]

  def index
    @repeating_classes_by_day = repeating_classes_by_day
  end

  def new
    @repeating_class = RepeatingClass.new
  end

  def create
    @repeating_class = current_user.instructor_profile.repeating_classes.create create_params
    if @repeating_class.valid?
      redirect_to confirm_repeating_class_path(@repeating_class)
    else
      @repeating_class = @repeating_class.decorate
      render :new
    end
  end

  def edit
    @repeating_class = @repeating_class.decorate
  end

  def update
    if @repeating_class.update_attributes create_params
      redirect_to confirm_repeating_class_path(@repeating_class)
    else
      @repeating_class = @repeating_class.decorate
      render :edit
    end
  end

  def confirm
    @repeating_class = @repeating_class.decorate
  end

  def confirmed
    if @repeating_class.update_attributes(confirmed: true)
      flash[:success] = "Repeating class created"
      redirect_to repeating_classes_path
    else
      @repeating_class = @repeating_class.decorate
      render :edit
    end
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

  def find_repeating_class
    @repeating_class = RepeatingClass.unconfirmed.find_by id: params[:id]
    if @repeating_class.nil?
      flash[:danger] = "Unable to find repeating class"
      redirect_to root_path
    end
  end

  def owns_repeating_class
    unless current_user.id == @repeating_class.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:repeating_class).permit(RepeatingClass::PERMITTED_PARAMS)
  end
end
