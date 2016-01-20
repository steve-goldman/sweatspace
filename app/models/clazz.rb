class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "timestamp",
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :class_template
  validates_presence_of :timestamp
end
