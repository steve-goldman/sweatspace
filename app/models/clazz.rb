class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "date",
    "time_of_day",
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
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }
  scope :canceled, -> { where canceled: true }
  scope :not_canceled, -> { where "canceled IS NULL OR canceled != 't'" }

  def make_into_repeating_class!
    create_repeating_class! class_template: class_template,
                            studio: studio,
                            instructor_profile: instructor_profile,
                            day_of_week: day_of_week_int,
                            time_of_day: time_of_day
    save!
  end

  def in_the_past?
    timestamp < Time.now
  end
end
