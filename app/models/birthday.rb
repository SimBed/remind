class Birthday < ApplicationRecord
  validates :first_name, :last_name, :date, presence: true
  scope :order_by_first_name, -> { order(first_name: :asc, last_name: :asc) }
  scope :order_by_last_name, -> { order(last_name: :asc, first_name: :asc) }
  scope :order_by_age, -> { order(date: :asc, first_name: :asc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def age_last_birthday(on_date = Date.today)
    age = on_date.year - date.year
    age -= 1 if on_date < date + age.years
    age
  end

  def this_years_birthday
    today = Date.today
    Date.new(today.year, date.month, date.day)
  end

  def midpoint
    this_years_birthday + ((this_years_birthday.advance(years: 1) - this_years_birthday) / 2)
  end
end
