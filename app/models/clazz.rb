class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "date",
    "time_of_day",
    "timestamp",
    "confirmed"
  ]

  include ClassTimeConcern

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  belongs_to :repeating_class
  validates_presence_of :timestamp, if: :confirmed?

  scope :confirmed, -> { where confirmed: true }
end
