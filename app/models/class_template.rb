class ClassTemplate < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name",
    "description",
    "duration",
    "studio_brand_id",
  ]

  acts_as_paranoid
  has_paper_trail

  has_many :class_template_class_types
  has_many :clazz_types, through: :class_template_class_types
  has_many :classes, class_name: "Clazz"
  belongs_to :studio_brand
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :duration
  validates_presence_of :studio_brand_id
end
