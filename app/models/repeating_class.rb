class RepeatingClass < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "studio_id",
    "first_date",
    "time_of_day",
    "number_of_weeks"
  ]

  before_save :set_day_of_week
  after_save :create_classes_hook

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :class_template
  belongs_to :studio
  has_many :classes, class_name: "Clazz"
  validates_presence_of :instructor_profile, :class_template, :studio
  validates_presence_of :day_of_week, :time_of_day, :class_template_id, :studio_id, :instructor_profile_id, if: :confirmed?
  validates_numericality_of :day_of_week,
                            only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 6, if: :confirmed?
  validates_presence_of :number_of_weeks, if: :confirmed?
  validates_numericality_of :number_of_weeks,
                            only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 12, if: :confirmed?

  scope :confirmed, -> { where confirmed: true }
  scope :unconfirmed, -> { where "confirmed IS NULL OR confirmed != 't'" }

  def remaining_classes
    classes.where "timestamp > ?", Time.now
  end

  def delete_from! last_clazz
    classes.where("timestamp >= ?", last_clazz.timestamp).destroy_all
    classes.each { |clazz| clazz.update_attributes repeating_class: nil }
    self.destroy
  end

  def open_ended?
    number_of_weeks == 0
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
    cur_date = first_future_date
    num_classes_need_creating.times.map do
      next_date = cur_date
      cur_date = next_date + 1.week
      next_date.strftime
    end
  end

  def next_day_of_week some_date
    next_date = some_date + 1.day
    next_date += 1.day while next_date.wday != day_of_week
    next_date
  end

  def first_future_date
    if last_class.nil?
      Date.parse first_date
    else
      next_day_of_week Date.parse(last_class.date)
    end
  end

  def num_classes_need_creating
    if open_ended?
      12 - remaining_classes.length
    else
      number_of_weeks
    end
  end

  def last_class
    @last_class ||= classes.order(timestamp: :desc).first
  end

  def set_day_of_week
    self.day_of_week ||= Date.parse(first_date).try :strftime, "%w"
  end

  def create_classes_hook
    if confirmed? && confirmed_changed?
      create_classes!
    end
  end
end
