class RecurringClassesController < ClassesControllerBase
  before_action :find_recurring_class, only: [:edit, :update, :confirm, :confirmed]
  before_action :owns_recurring_class, only: [:edit, :update, :confirm, :confirmed]

  def index
    @recurring_classes_by_day = recurring_classes_by_day
  end

  def new
    @recurring_class = RecurringClass.new
  end

  def create
    @recurring_class = current_user.instructor_profile.recurring_classes.create create_params
    if @recurring_class.valid?
      redirect_to confirm_recurring_class_path(@recurring_class)
    else
      @recurring_class = @recurring_class.decorate
      render :new
    end
  end

  def edit
    @recurring_class = @recurring_class.decorate
  end

  def update
    if @recurring_class.update_attributes create_params
      redirect_to confirm_recurring_class_path(@recurring_class)
    else
      @recurring_class = @recurring_class.decorate
      render :edit
    end
  end

  def confirm
    @recurring_class = @recurring_class.decorate
    NavbarConfig.instance.back_link = edit_recurring_class_path @recurring_class
  end

  def confirmed
    if @recurring_class.create_classes && @recurring_class.update_attributes(confirmed: true)
      flash[:success] = "Recurring class created"
      redirect_to profile_path(current_user.instructor_profile.profile_path)
    else
      @recurring_class = @recurring_class.decorate
      render :edit
    end
  end

  private

  def recurring_classes_by_day
    recurring_classes.each_with_object({}) do |recurring_class, recurring_classes_by_day|
      (recurring_classes_by_day[recurring_class.day_of_week] ||= []).push recurring_class
    end
  end

  def recurring_classes
    @recurring_classes ||= current_user.instructor_profile.recurring_classes.confirmed
      .order(day_of_week: :asc).decorate
  end

  def find_recurring_class
    @recurring_class = RecurringClass.unconfirmed.find_by id: params[:id]
    if @recurring_class.nil?
      flash[:danger] = "Unable to find recurring class"
      redirect_to root_path
    end
  end

  def owns_recurring_class
    unless current_user.id == @recurring_class.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:recurring_class).permit(RecurringClass::PERMITTED_PARAMS)
  end
end
