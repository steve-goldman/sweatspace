class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "date",
    "time_of_day"
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  belongs_to :recurring_class
  validates_presence_of :instructor_profile, :class_template, :studio
  validates_presence_of :timestamp
  validates_format_of :date, with: /\A\d\d\d\d-\d\d-\d\d\z/i
  validates_format_of :time_of_day, with: /\A\d\d:\d\d (AM|PM)\z/i
  validates :timestamp, date: { after: Proc.new { Time.now } }
  before_validation :set_timestamp

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }
  scope :canceled, -> { where canceled: true }
  scope :not_canceled, -> { where "canceled IS NULL OR canceled != 't'" }

  delegate :class_timestamp, :in_the_past?, to: :time_service

  private

  def time_service
    @time_service ||= ClassTimeService.new self
  end

  def set_timestamp
    if timestamp.nil? || date_changed? || time_of_day_changed?
      self.timestamp = time_service.make_timestamp
    end
  end
end
