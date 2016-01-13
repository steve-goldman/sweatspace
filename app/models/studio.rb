class Studio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "url",
  ]

  validates_presence_of :name
  validates_presence_of :url
  validates_format_of :url, with: URI.regexp
  has_paper_trail
end
