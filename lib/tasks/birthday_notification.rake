desc "Send birthday notification"
task notify: :environment do
  today = Date.today

  birthdays = Birthday.where(
    "EXTRACT(month FROM date) = ? AND EXTRACT(day FROM date) = ?",
    today.month,
    today.day
  )

  if birthdays.empty?
    puts "No birthdays today"
    return
  end

  names = birthdays.map(&:full_name).join(", ")

  FirebaseNotifier.new.notify(
    title: "🎂 Birthday Reminder",
    body: "Today is #{names}'s birthday!"
  )

  puts "Sent birthday notification for: #{names}"
end
