class Birthday < ApplicationRecord
  validates :first_name, :last_name, :date, presence: true
  scope :order_by_first_name, -> { order(first_name: :asc, last_name: :asc) }
  scope :order_by_last_name, -> { order(last_name: :asc, first_name: :asc) }
  scope :order_by_age, -> { order(date: :asc, first_name: :asc) }
  scope :order_by_upcoming, lambda {
    order(
      Arel.sql(<<~SQL)
        (
          CASE
            WHEN
              (EXTRACT(MONTH FROM date), EXTRACT(DAY FROM date))
              >=
              (EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(DAY FROM CURRENT_DATE))
            THEN
              make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int,
                        EXTRACT(MONTH FROM date)::int,
                        EXTRACT(DAY FROM date)::int)
            ELSE
              make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int + 1,
                        EXTRACT(MONTH FROM date)::int,
                        EXTRACT(DAY FROM date)::int)
          END
        )
      SQL
    )
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
