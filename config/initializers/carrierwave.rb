require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = Figaro.env.aws_s3_bucket_name
  config.aws_acl = "public-read"

  # The maximum period for authenticated_urls is only 7 days.
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: 'max-age=604800'
  }

  config.aws_credentials = {
    access_key_id: Figaro.env.aws_access_key,
    secret_access_key: Figaro.env.aws_secret_access_key,
    region: Figaro.env.aws_s3_region,
  }
end
