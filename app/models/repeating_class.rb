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
  validates_numericality_of :number_of_weeks,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 12,
                            allow_nil: true,
                            unless: :forever?

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }
end
