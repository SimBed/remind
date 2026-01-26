desc "Send birthday notification"
task notify: :environment do
    notify_birthdays
end

def notify_birthdays
  birthdays = BirthdayWithUpcoming.upcoming_birthday_today
  midpoints = BirthdayWithUpcoming.upcoming_midpoint_today

  # return works here because we are inside a method. If (instead) the notify_birthdays code was directly inside the rake task,
  # we'd get unexpected return (LocalJumpError) because in a rake task, the task body is not a method.
  return if (birthdays + midpoints).empty?

  FirebaseNotifier.new.notify(
    title: "🎂🎉🎈🎁🎯 Reminder",
    body: MessageWriter.new(birthdays, midpoints).write_message
  )
end
