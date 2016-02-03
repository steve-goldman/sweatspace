class ClassesController < ApplicationController
  before_action :find_clazz, only: [:edit, :update, :confirm, :confirmed]
  before_action :owns_clazz, only: [:edit, :update, :confirm, :confirmed]

  def index
    @classes_by_date = classes_by_date
    @date_range = date_range
    @presenter = InstructorClassesPresenter.new classes_by_date, date_range
  end

  def new
    @clazz = Clazz.new
  end

  def create
    @clazz = current_user.instructor_profile.classes.create create_params
    if @clazz.valid?
      redirect_to confirm_class_path(@clazz)
    else
      @clazz = @clazz.decorate
      render :new
    end
  end

  def edit
    @clazz = @clazz.decorate
  end

  def update
    if @clazz.update_attributes create_params
      redirect_to confirm_class_path(@clazz)
    else
      @clazz = @clazz.decorate
      render :edit
    end
  end

  def confirm
    @clazz = @clazz.decorate
  end

  def confirmed
    if @clazz.update_attributes confirmed: true
      flash[:success] = "Class created"
      redirect_to classes_path
    else
      @clazz = @clazz.decorate
      render :edit
    end
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
    @date_range ||= DateRange.new current_user, params[:min_date], params[:max_date]
  end

  def find_clazz
    @clazz = Clazz.unconfirmed.find_by id: params[:id]
    if @clazz.nil?
      flash[:danger] = "Unable to find class"
      redirect_to root_path
    end
  end

  def owns_clazz
    unless current_user.id == @clazz.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
  end
end
