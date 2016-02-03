class ClassTimeService
  attr_reader :clazz
  delegate :studio, :date, :time_of_day, :timestamp, to: :clazz

  def initialize clazz
    @clazz = clazz
  end

  def class_timestamp
    if timestamp.present?
      @class_timestamp ||= timestamp.in_time_zone time_zone
    end
  end

  def in_the_past?
    timestamp < Time.now
  end

  def make_timestamp
    if studio.present? && date.present? && time_of_day.present?
      date_tokens = /(\d\d\d\d)-(\d\d)-(\d\d)/.match(date)
      time_tokens = /(\d\d):(\d\d) (AM|PM)/.match(time_of_day)
      Time.new date_tokens[1], date_tokens[2], date_tokens[3],
               time_tokens[3] == "AM" ? (time_tokens[1].to_i % 12) : (time_tokens[1].to_i % 12 + 12), time_tokens[2], 0,
               formatted_time_zone_offset
    end
  end

  private

  def formatted_time_zone_offset
    @formatted_offset ||= sprintf("%s%02d:%02d",
                                  time_zone_offset < 0 ? "-" : "",
                                  time_zone_offset.abs / 3600,
                                  (time_zone_offset.abs % 3600) / 60)
  end

  def time_zone_offset
    @time_zone_offset ||=
      time_zone.utc_offset +
      ((Date.parse(date) + 1.day).to_time.in_time_zone(time_zone).dst? ? 3600 : 0)
  end

  def time_zone
    @time_zone ||= ActiveSupport::TimeZone.new studio.timezone
  end
end
