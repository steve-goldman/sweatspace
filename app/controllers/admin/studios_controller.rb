class Admin::StudiosController < Admin::ControllerBase
  before_action :find_studio, only: [:edit, :update]

  def index
    @studios = Studio.order(name: :asc, site: :asc).decorate
  end

  def new
    @studio = Studio.new
  end

  def edit
    @studio = @studio.decorate
  end

  def create
    @studio = Studio.new create_params
    if @studio.save
      flash[:success] = "Studio created"
      redirect_to edit_admin_studio_path(@studio)
    else
      render :new
    end
  end

  def update
    if @studio.update_attributes create_params
      flash[:success] = "Studio saved"
      redirect_to admin_studios_path
    else
      render :edit
    end
  end

  private

  def find_studio
    @studio = Studio.find_by id: params[:id]
    if @studio.nil?
      flash[:danger] = "Unable to find studio"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:studio).permit(Studio::PERMITTED_PARAMS)
  end
end
