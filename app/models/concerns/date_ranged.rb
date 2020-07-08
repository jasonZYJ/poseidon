module DateRanged
  extend ActiveSupport::Concern

  def range(timestamp=false)
    start_date || Date.today .. range_end_date(timestamp)
  end

  def range_end_date(timestamp)
    (end_date || Date.today) + (timestamp ? 1.day : 0)
  end

  def range_in_utc(time_zone)
    date_in_zone(start_date || Date.today, time_zone) .. date_in_zone(range_end_date(true), time_zone)
  end

  protected

  def date_in_zone date, time_zone
    time_zone.present? ? date.in_time_zone(time_zone).in_time_zone('UTC') : date
  end
end
