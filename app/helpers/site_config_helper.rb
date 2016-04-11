module SiteConfigHelper
  def landing_page_cover_photo_url size
    sweatspace_image_url SiteConfig.get.landing_page_cover_photo.send(size)
  end
end
