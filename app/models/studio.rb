class Studio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "url",
    "timezone",
  ]

  validates_presence_of :name, :url, :timezone
  validates_format_of :url, with: URI.regexp
  has_paper_trail
end
