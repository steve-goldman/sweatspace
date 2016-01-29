class Admin::StudiosController < Admin::ControllerBase
  before_action :find_studio, only: [:edit, :update]

  def index
    @studios = Studio.all
  end

  def new
    @studio = Studio.new
  end

  def edit
  end

  def create
    @studio = Studio.new create_params
    if @studio.save
      flash[:success] = "Studio created"
      redirect_to edit_admin_studio_path(@studio)
    else
      flash.now[:danger] = "Could not create studio"
      render :new
    end
  end

  def update
    if @studio.update_attributes create_params
      flash[:success] = "Class type saved"
      redirect_to admin_studios_path
    else
      flash[:danger] = "Could not save class type"
      render :edit
    end
  end

  private

  def find_studio
    @studio = Studio.find_by id: params[:id]
    if @studio.nil?
      flash[:danger] = "Unable to find class type"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:studio).permit(Studio::PERMITTED_PARAMS)
  end
end
