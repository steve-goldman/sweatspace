class RepeatingClass < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "day_of_week",
    "time",
    "class_template_id",
    "studio_id",
    "instructor_profile_id",
    "forever",
    "last_created_date",
    "confirmed"
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  has_many :classes, class_name: "Clazz"
  validates_presence_of :day_of_week, :time, :class_template_id, :studio_id, :instructor_profile_id

  scope :confirmed, -> { where confirmed: true }
end
