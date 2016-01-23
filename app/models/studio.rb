class Studio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "url",
    "timezone",
  ]

  has_paper_trail

  has_many :classes, class_name: "Clazz"
  has_many :class_template_studios
  has_many :class_templates, through: :class_template_studios
  validates_presence_of :name, :url, :timezone
  validates_format_of :url, with: URI.regexp
end
