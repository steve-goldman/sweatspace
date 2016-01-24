module ClassTimeConcern
  extend ActiveSupport::Concern

  included do
    before_validation :set_timestamp
  end

  def class_timestamp
    @class_timestamp ||= timestamp.in_time_zone timezone
  end

  private

  def set_timestamp
    if timestamp.nil? || date_changed? || time_of_day_changed?
      if studio.present? && date.present? && time_of_day.present?
        self.timestamp = TimeService.instance.timestamp date, time_of_day, timezone
      end
    end
  end

  def timezone
    @timezone ||= studio.timezone
  end
end
