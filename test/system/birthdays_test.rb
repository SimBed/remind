require "application_system_test_case"

class BirthdaysTest < ApplicationSystemTestCase
  setup do
    @birthday = birthdays(:bob)
  end

  test "visiting the index" do
    visit birthdays_path
    assert_selector "h1", text: "Birthday"
  end

  test "should create birthday" do
    visit birthdays_path
    click_on "Birthday 🎁 🎈"

    fill_in "Date", with: @birthday.date
    fill_in "First name", with: @birthday.first_name
    fill_in "Last name", with: @birthday.last_name
    click_on "Create Birthday"

    assert_text "Birthday was successfully added"
  end

  test "should destroy Birthday" do
    visit birthdays_path
    click_on "Delete Birthday", match: :first

    assert_text "Birthday was successfully deleted"
  end
end
