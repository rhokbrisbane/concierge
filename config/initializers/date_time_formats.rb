# TODO: put it in locale files
formats = {
  year_first: "%Y/%m/%d",
  month_first: "%m/%d/%Y",
  day_first: "%d/%m/%Y",
  time_with_date: "%I:%M %p - %d/%m/%Y",
  year_first_with_time: "%Y/%m/%d %I:%M%P",
  month_first_with_time: "%m/%d/%Y %I:%M%P",
  day_first_with_time: "%d/%m/%Y %I:%M%P",
  day_only: "%d",
  short_month: "%b",
}

Date::DATE_FORMATS.merge!(formats)
Time::DATE_FORMATS.merge!(formats)
