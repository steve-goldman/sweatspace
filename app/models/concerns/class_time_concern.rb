module ClassTimeConcern
  extend ActiveSupport::Concern

  included do
    validates_format_of :date, with: /\A\d\d\d\d-\d\d-\d\d\z/i, allow_blank: true
    validates_format_of :time_of_day, with: /\A\d\d:\d\d (AM|PM)\z/i, allow_blank: true
    validates :timestamp, date: true, if: "date? && time_of_day?"
    before_validation :set_timestamp
  end

  def class_timestamp
    @class_timestamp ||= timestamp.in_time_zone timezone
  end

  private

  def set_timestamp
    if timestamp.nil? || date_changed? || time_of_day_changed?
      if studio.present? && date.present? && time_of_day.present?
        self.timestamp = make_timestamp
      end
    end
  end

  def make_timestamp
    date_tokens = /(\d\d\d\d)-(\d\d)-(\d\d)/.match(date)
    time_tokens = /(\d\d):(\d\d) (AM|PM)/.match(time_of_day)
    Time.new date_tokens[1], date_tokens[2], date_tokens[3],
             time_tokens[3] == "AM" ? (time_tokens[1].to_i % 12) : (time_tokens[1].to_i % 12 + 12), time_tokens[2], 0,
             ActiveSupport::TimeZone.new(timezone).formatted_offset
  end

  def day_of_week
    class_timestamp.strftime "%A"
  end

  def timezone
    @timezone ||= studio.timezone
  end
end
