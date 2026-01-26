require "test_helper"

class MessageWriterTest  < ActiveSupport::TestCase
  test "writes a single line when one birthday" do
    peter = Birthday.new(
      first_name: "Peter",
      last_name: "Smith",
      date: Date.new(2006, 1, 21)
    )

    message = MessageWriter.new([ peter ], []).write_message

    assert_equal(
      "🎂 Peter Smith is 20 today!",
      message
      )
  end
  test "writes a single line when one midpoint" do
    peter = Birthday.new(
      first_name: "Peter",
      last_name: "Smith",
      date: Date.new(2006, 1, 21)
    )

    message = MessageWriter.new([], [ peter ]).write_message

    assert_equal(
      "🎯 Peter Smith is 20.5 today!",
      message
      )
  end
  test "writes one line per occasion with correct ages" do
    peter = Birthday.new(
      first_name: "Peter",
      last_name: "Smith",
      date: Date.new(2006, 1, 21)
    )

    alice = Birthday.new(
      first_name: "Alice",
      last_name: "Jones",
      date: Date.new(2001, 5, 2)
    )

    ben = Birthday.new(
      first_name: "Ben",
      last_name: "Mc",
      date: Date.new(1999, 6, 7)
    )

    message = MessageWriter.new([ peter, alice ], [ ben ]).write_message

    assert_equal(
      "🎂 Peter Smith is 20 today!\n🎂 Alice Jones is 24 today!\n🎯 Ben Mc is 26.5 today!",
      message
    )
  end
end
