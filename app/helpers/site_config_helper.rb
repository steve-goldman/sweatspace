module SiteConfigHelper
  def landing_page_cover_photo_url
    SiteConfig.get.landing_page_cover_photo_url
  end
end
