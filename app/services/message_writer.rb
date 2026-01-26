class MessageWriter
  def initialize(birthdays, midpoints)
    @birthdays = birthdays
    @midpoints = midpoints
  end

  def write_message
    return if @birthdays.empty? && @midpoints.empty?

    return @birthdays.map { |birthday| write_line(birthday) }.join("\n") if @midpoints.empty?

    return @midpoints.map { |midpoint| write_line(midpoint, :midpoint) }.join("\n") if @birthdays.empty?

    @birthdays.map { |birthday| write_line(birthday) }.join("\n") +
    "\n" +
    @midpoints.map { |midpoint| write_line(midpoint, :midpoint) }.join("\n")
  end

  private
  def write_line(birthday, occasion = :birthday)
    case occasion
    when :birthday
      "🎂 #{birthday.full_name} is #{birthday.age_last_birthday} today!"
    when :midpoint
      "🎯 #{birthday.full_name} is #{birthday.age_last_birthday + 0.5} today!"
    end
  end
end
