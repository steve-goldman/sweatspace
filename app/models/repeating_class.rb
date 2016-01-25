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
  validates_numericality_of :day_of_week,
                            only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 6
  validates_numericality_of :number_of_weeks,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 12,
                            allow_nil: true,
                            unless: :forever?

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }

  def remaining_classes
    classes.where "timestamp > ?", Time.now
  end

  def create_classes!
    future_dates.each do |future_date|
      classes.create! class_template: class_template,
                      instructor_profile: instructor_profile,
                      studio: studio,
                      confirmed: true,
                      date: future_date,
                      time_of_day: time_of_day
    end
  end

  private

  def future_dates
    last_date = next_day_of_week Date.parse(last_class.date)
    num_classes_need_creating.times.map do
      next_date = last_date
      last_date = next_date + 1.week
      next_date.strftime
    end
  end

  def next_day_of_week some_date
    next_date = some_date + 1.day
    next_date += 1.day while next_date.wday != day_of_week
    next_date
  end

  def num_classes_need_creating
    if forever
      12 - classes.where("timestamp > ?", Time.now).length
    else
      number_of_weeks - 1
    end
  end

  def last_class
    @last_class ||= classes.order(timestamp: :desc).first
  end
end
