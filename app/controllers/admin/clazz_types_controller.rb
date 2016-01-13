class Admin::ClazzTypesController < Admin::ControllerBase
  before_action :find_clazz_type, only: [:edit, :update]

  def index
    @clazz_types = ClazzType.all
  end

  def new
    @clazz_type = ClazzType.new
  end

  def edit
  end

  def create
    @clazz_type = ClazzType.new create_params
    if @clazz_type.save
      flash[:success] = "Class type created"
      redirect_to admin_clazz_types_path
    else
      flash[:danger] = "Could not create class type"
      render :new
    end
  end

  def update
    if @clazz_type.update_attributes create_params
      flash[:success] = "Class type saved"
      redirect_to admin_clazz_types_path
    else
      flash[:danger] = "Could not save class type"
      render :edit
    end
  end

  private

  def find_clazz_type
    @clazz_type = ClazzType.find_by id: params[:id]
    if @clazz_type.nil?
      flash[:danger] = "Unable to find class type"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:clazz_type).permit(ClazzType::PERMITTED_PARAMS)
  end
end
