class ClassTemplate < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "clazz_type_id",
    "name",
    "description",
    "duration",
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :clazz_type
  has_many :classes, class_name: "Clazz"
  has_many :class_template_studios
  has_many :studios, through: :class_template_studios
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :duration
end
