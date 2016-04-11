module SiteConfigHelper
  def landing_page_cover_photo_url size
    SiteConfig.get.landing_page_cover_photo.send(size).url
  end
end
