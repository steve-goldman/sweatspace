class ClassTemplateStudio < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id"
  ]

  belongs_to :class_template
  belongs_to :studio
end
