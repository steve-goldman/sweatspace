class ClassesController < ClassesControllerBase
  before_action :find_clazz, except: [:new, :create]
  before_action :owns_clazz, except: [:new, :create, :show]

  def show
    @is_owner = owner?
    @clazz = @clazz.decorate
    NavbarConfig.instance.back_link = request.referer || profile_path(@clazz.instructor_profile.profile_path)
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
    NavbarConfig.instance.back_link = edit_class_path @clazz
  end

  def confirmed
    if @clazz.update_attributes confirmed: true
      flash[:success] = "Class created"
      redirect_to profile_path(current_user.instructor_profile.profile_path)
    else
      @clazz = @clazz.decorate
      render :edit
    end
  end

  private

  def find_clazz
    @clazz = clazz_scope.find_by id: params[:id]
    if @clazz.nil?
      flash[:danger] = "Unable to find class"
      redirect_to root_path
    end
  end

  def owner?
    user_signed_in? && current_user.id == @clazz.instructor_profile.user_id
  end

  def owns_clazz
    unless owner?
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def clazz_scope
    if action_name == "show"
      Clazz.confirmed
    else
      Clazz.unconfirmed
    end
  end

  def create_params
    params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
  end
end
