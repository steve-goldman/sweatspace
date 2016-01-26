class ClassTemplateClassType < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "clazz_type_id"
  ]

  belongs_to :class_template
  belongs_to :clazz_type
end
