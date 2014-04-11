# encoding: UTF-8

class Date
  def to_i
    to_utc_time.to_i
  end

  def self.on(unix_time)
    Time.at(unix_time).utc.to_date
  end

  def to_utc_time
    Time.utc(year, month, day)
  end
end
