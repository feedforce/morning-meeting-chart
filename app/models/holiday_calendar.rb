module HolidayCalendar
  def self.start_week_day(date)
    start_date = date - (date.wday - 1)
    loop do
      return start_date unless HolidayJp.holiday?(start_date)
      start_date += 1.days
    end
  end
end
