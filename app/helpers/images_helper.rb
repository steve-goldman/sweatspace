module ImagesHelper
  # this is a workaround because image_tag prepends paths with an unwanted 'images',
  # so we prepend the path with a slash when using an asset_host
  def sweatspace_image object, options = {}
    path = sweatspace_image_path object
    image_tag path, options
  end

  def sweatspace_image_path object
    if ActionController::Base.asset_host
      "/#{object.path}"
    else
      object.url
    end
  end

  def sweatspace_image_url object
    if ActionController::Base.asset_host
      "#{ActionController::Base.asset_host}/#{object.path}"
    else
      object.url
    end
  end
end
