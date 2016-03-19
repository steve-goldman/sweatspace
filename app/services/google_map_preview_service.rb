class GoogleMapPreviewService
  attr_reader :address, :width, :height, :zoom

  def initialize address, width, height, zoom
    @address = Array.wrap address
    @width = width
    @height = height
    @zoom = zoom
  end

  def url
    "#{url_stem}?markers=#{address}&zoom=#{zoom}&size=#{width}x#{height}"
  end

  private

  def address
    @address.join(",").gsub(" ", "+")
  end

  def url_stem
    "https://maps.googleapis.com/maps/api/staticmap"
  end
end
