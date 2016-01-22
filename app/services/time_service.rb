class TimeService
  include Singleton

  def timestamp date, time, timezone
    date_tokens = /(\d\d\d\d)-(\d\d)-(\d\d)/.match(date)
    if date_tokens.present?
      time_tokens = /(\d\d):(\d\d) (AM|PM)/.match(time)
      if time_tokens
        Time.new date_tokens[1], date_tokens[2], date_tokens[3],
                 time_tokens[3] == "AM" ? (time_tokens[1].to_i % 12) : (time_tokens[1].to_i % 12 + 12), time_tokens[2], 0,
                 ActiveSupport::TimeZone.new(timezone).formatted_offset
      end
    end
  end

  def date timestamp, timezone
    timestamp.in_time_zone(timezone).midnight
  end

  def display_date timestamp, timezone
    date(timestamp, timezone).strftime "%Y-%m-%d"
  end
end
