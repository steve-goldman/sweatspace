class Admin::StudioBrandsController < Admin::ControllerBase
  before_action :find_studio_brand, only: [:edit, :update]

  def index
    @studio_brands = StudioBrand.order(name: :asc).decorate
  end

  def new
    @studio_brand = StudioBrand.new
  end

  def edit
    @studio_brand = @studio_brand.decorate
  end

  def create
    @studio_brand = StudioBrand.new create_params
    if @studio_brand.save
      flash[:success] = "Studio brand created"
      redirect_to edit_admin_studio_brand_path(@studio_brand)
    else
      render :new
    end
  end

  def update
    if @studio_brand.update_attributes create_params
      flash[:success] = "Studio brand saved"
      redirect_to admin_studio_brands_path
    else
      render :edit
    end
  end

  private

  def find_studio_brand
    @studio_brand = StudioBrand.find_by id: params[:id]
    if @studio_brand.nil?
      flash[:danger] = "Unable to find studio brand"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:studio_brand).permit(StudioBrand::PERMITTED_PARAMS)
  end
end
