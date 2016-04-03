class StudioBrand < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "url",
  ]

  acts_as_paranoid
  has_paper_trail

  has_many :studio_brand_studios
  has_many :studios, through: :studio_brand_studios
  has_many :class_templates
  validates_presence_of :name, :url
  validates_format_of :url, with: URI.regexp
end
