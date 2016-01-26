class ClazzType < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name"
  ]

  validates_presence_of :name
  validates_uniqueness_of :name
  has_paper_trail

  has_many :class_template_class_types
  has_many :class_templates, through: :class_template_class_types
end
