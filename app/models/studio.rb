class Studio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "site",
    "url",
    "map_url",
    "timezone",
    "address_1",
    "address_2",
    "address_3",
  ]

  acts_as_paranoid
  has_paper_trail

  has_many :classes, class_name: "Clazz"
  has_many :class_template_studios
  has_many :class_templates, through: :class_template_studios
  validates_presence_of :name, :url, :map_url, :timezone
  validates_format_of :url, with: URI.regexp
  validates_format_of :map_url, with: /\Ahttps:\/\/www.google.com\/maps\/place\/.+\/@-?[0-9]+\.[0-9]+,-?[0-9]+\.[0-9]+,[0-9]+z/
end
