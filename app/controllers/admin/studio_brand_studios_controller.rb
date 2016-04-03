class Admin::StudioBrandStudiosController < Admin::ControllerBase
  before_action :find_studio_brand_studio, only: :destroy

  def create
    studio_brand_studio = StudioBrandStudio.create create_params
    if studio_brand_studio.persisted?
      flash[:success] = "studio brand linked to studio"
      redirect_to request.referer || edit_admin_studio_brand_path(studio_brand_studio.studio_brand)
    else
      redirect_to request.referer || root_path
    end
  end

  def destroy
    @studio_brand_studio.destroy!
    flash[:success] = "studio brand unlinked from studio"
    redirect_to request.referer || edit_admin_studio_brand_path(@studio_brand_studio.studio_brand)
  end

  private

  def find_studio_brand_studio
    @studio_brand_studio = StudioBrandStudio.find_by id: params[:id]
    if @studio_brand_studio.nil?
      flash[:danger] = "Could not find studio brand studio"
      redirect_to request.referer
    end
  end

  def create_params
    params.require(:studio_brand_studio).permit(StudioBrandStudio::PERMITTED_PARAMS)
  end
end
