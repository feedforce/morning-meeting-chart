module HolidayCalendar
  def self.start_week_day(date)
    start_date = date - (date.wday - 1)
    loop do
      return start_date unless HolidayJp.holiday?(start_date)
      start_date += 1.days
    end
  end

  def self.end_week_day(date)
    end_date = date - (date.wday - 5)
    loop do
      return end_date unless HolidayJp.holiday?(end_date)
      end_date -= 1.days
    end
  end
end
