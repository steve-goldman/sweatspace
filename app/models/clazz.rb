class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "duration",
    "date",
    "time_of_day"
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  belongs_to :recurring_class

  before_validation :set_timestamps
  validates_presence_of :instructor_profile, :class_template, :studio, :timestamp, :duration
  validates_format_of :date, with: /\A\d\d\d\d-\d\d-\d\d\z/i
  validates_format_of :time_of_day, with: /\A\d\d:\d\d (AM|PM)\z/i
  validates :timestamp, date: { after: Proc.new { Time.now } }
  validate :timespan_free

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }
  scope :canceled, -> { where canceled: true }
  scope :not_canceled, -> { where "canceled IS NULL OR canceled != 't'" }
  scope :substituted, -> { where substituted: true }
  scope :not_substituted, -> { where "substituted IS NULL OR substituted != 't'" }

  delegate :timespan_free, :class_timestamp, :in_the_past?, to: :time_service

  private

  def time_service
    @time_service ||= ClassTimeService.new self
  end

  def set_timestamps
    if timestamp.nil? || date_changed? || time_of_day_changed? || duration_changed?
      self.timestamp = time_service.make_timestamp
      if timestamp && duration
        self.end_timestamp = timestamp + duration.minutes
      end
    end
  end
end
