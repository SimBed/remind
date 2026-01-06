require "application_system_test_case"

class BirthdaysTest < ApplicationSystemTestCase
  setup do
    @birthday = birthdays(:one)
  end

  test "visiting the index" do
    visit birthdays_url
    assert_selector "h1", text: "Birthdays"
  end

  test "should create birthday" do
    visit birthdays_url
    click_on "New birthday"

    fill_in "Date", with: @birthday.date
    fill_in "First name", with: @birthday.first_name
    fill_in "Last name", with: @birthday.last_name
    click_on "Create Birthday"

    assert_text "Birthday was successfully created"
    click_on "Back"
  end

  test "should update Birthday" do
    visit birthday_url(@birthday)
    click_on "Edit this birthday", match: :first

    fill_in "Date", with: @birthday.date
    fill_in "First name", with: @birthday.first_name
    fill_in "Last name", with: @birthday.last_name
    click_on "Update Birthday"

    assert_text "Birthday was successfully updated"
    click_on "Back"
  end

  test "should destroy Birthday" do
    visit birthday_url(@birthday)
    click_on "Destroy this birthday", match: :first

    assert_text "Birthday was successfully destroyed"
  end
end
