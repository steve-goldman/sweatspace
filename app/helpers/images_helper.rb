module ImagesHelper
  # this is a workaround because image_tag prepends paths with an unwanted 'images',
  # so we prepend the path with a slash when using an asset_host
  def sweatspace_image object, options = {}
    path = if ActionController::Base.asset_host
             "/#{object.path}"
           else
             object.url
           end
    image_tag path, options
  end
end
