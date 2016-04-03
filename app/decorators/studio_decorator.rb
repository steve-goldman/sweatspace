class StudioDecorator < Draper::Decorator
  delegate_all
  decorates_association :studio_brand_studios
  delegate :url, to: :studio_brand

  def full_name
    "#{name} #{site}"
  end

  def map_preview_url
    GoogleMapPreviewService.new([address_1, address_2, address_3], 252, 252, 15).url
  end
end
