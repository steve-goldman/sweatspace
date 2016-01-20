class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "class_template_id",
    "timestamp",
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :class_template
  validates_presence_of :timestamp

  def class_date
    in_time_zone.try :strftime, "%Y-%m-%d"
  end

  def class_time
    in_time_zone.try :strftime, "%I:%M %p"
  end

  private

  def in_time_zone
    if class_template.present? && timestamp.present?
      @in_time_zone ||= timestamp.in_time_zone class_template.studio.timezone
    end
  end
end
