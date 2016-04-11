class Admin::LandingPageController < Admin::ControllerBase
  def edit
    @site_config = SiteConfig.get
    @has_cover_photo = @site_config.landing_page_cover_photo?
    @cover_photo = @site_config.landing_page_cover_photo
  end

  def update
    SiteConfig.get.update_attributes update_params
    redirect_to edit_admin_landing_page_path  
  end

  private

  def update_params
    params.require(:site_config).permit(SiteConfig::PERMITTED_PARAMS)
  end
end
