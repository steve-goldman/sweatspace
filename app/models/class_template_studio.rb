class ClassTemplateStudio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id"
  ]

  belongs_to :class_template
  belongs_to :studio
  validates_presence_of :class_template_id, :studio_id
end
