desc "Send birthday notification"
task notify: :environment do
    notify_birthdays
end

def notify_birthdays
  birthdays = Birthday.today

  if birthdays.empty?
    puts "No birthdays today"
    return # return works her becasue inside a method. If the content of notify methods was directly inside the rake task,
    # we'd get unexpected return (LocalJumpError) because in a rake task, the task body is not a method.
  end

  names = birthdays.map(&:full_name).join(", ")

  FirebaseNotifier.new.notify(
    title: "🎂 Birthday Reminder",
    body: "Today is #{names}'s birthday!"
  )

  puts "Sent birthday notification for: #{names}"
end
