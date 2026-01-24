class CreateBirthdaysWithUpcoming < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE VIEW birthdays_with_upcoming AS
      SELECT
        base.*,
        CASE
          WHEN (base.upcoming_birthday - INTERVAL '6 months') >= CURRENT_DATE
          THEN (base.upcoming_birthday - INTERVAL '6 months')
          ELSE (base.upcoming_birthday + INTERVAL '6 months')
        END AS upcoming_midpoint
      FROM (
        SELECT
          birthdays.*,
          CASE
            WHEN make_date(
              EXTRACT(year FROM CURRENT_DATE)::int,
              EXTRACT(month FROM date)::int,
              EXTRACT(day FROM date)::int
            ) >= CURRENT_DATE
            THEN make_date(
              EXTRACT(year FROM CURRENT_DATE)::int,
              EXTRACT(month FROM date)::int,
              EXTRACT(day FROM date)::int
            )
            ELSE make_date(
              EXTRACT(year FROM CURRENT_DATE)::int + 1,
              EXTRACT(month FROM date)::int,
              EXTRACT(day FROM date)::int
            )
          END AS upcoming_birthday
        FROM birthdays
      ) base;
    SQL
  end

  def down
    execute <<~SQL
      DROP VIEW IF EXISTS birthdays_with_upcoming;
    SQL
  end
end
