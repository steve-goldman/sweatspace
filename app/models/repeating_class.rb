class RepeatingClass < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "forever",
    "number_of_weeks",
    "confirmed"
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  has_many :classes, class_name: "Clazz"
  validates_presence_of :day_of_week, :time_of_day, :class_template_id, :studio_id, :instructor_profile_id
  validates_presence_of :number_of_weeks?, if: :forever?

  scope :confirmed, -> { where confirmed: true }
end
