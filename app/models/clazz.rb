class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "timestamp",
    "confirmed"
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  validates_presence_of :timestamp, if: :confirmed?

  scope :confirmed, -> { where confirmed: true }

  def class_date
    in_time_zone.try :strftime, "%Y-%m-%d"
  end

  def class_time
    in_time_zone.try :strftime, "%I:%M %p"
  end

  private

  def in_time_zone
    if class_template.present? && timestamp.present?
      @in_time_zone ||= timestamp.in_time_zone studio.timezone
    end
  end
end
