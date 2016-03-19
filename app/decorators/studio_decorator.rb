class StudioDecorator < Draper::Decorator
  delegate_all

  def map_preview_url
    GoogleMapPreviewService.new([address_1, address_2, address_3], 252, 252, 15).url
  end
end