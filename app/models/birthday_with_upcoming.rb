class BirthdayWithUpcoming < Birthday
  self.table_name = "birthdays_with_upcoming"

  scope :order_by_upcoming_birthday, -> { order(:upcoming_birthday) }
  scope :order_by_upcoming_midpoint, -> { order(:upcoming_midpoint) }
  scope :upcoming_birthday_today, -> { where(upcoming_birthday: Date.today) }
  scope :upcoming_midpoint_today, -> { where(upcoming_midpoint: Date.today) }
end
