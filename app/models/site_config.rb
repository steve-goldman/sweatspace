class SiteConfig < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "landing_page_cover_photo",
    "remove_landing_page_cover_photo",
  ]

  has_paper_trail
  mount_uploader :landing_page_cover_photo, LandingPageCoverPhotoUploader
  validates :landing_page_cover_photo,
            file_size: { less_than: 10.megabytes }

  def self.get
    SiteConfig.first
  end
end
