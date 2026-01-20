require "test_helper"

class BirthdaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @birthday = birthdays(:bob)
  end

  test "should get index" do
    get birthdays_path
    assert_response :success
  end

  test "should get new" do
    get new_birthday_path
    assert_response :success
  end

  test "should create birthday" do
    assert_difference("Birthday.count") do
      post birthdays_path, params: { birthday: { date: Date.parse("March 14 1992"), first_name: "Sally", last_name: "Kelly" } }
    end

    assert_redirected_to birthdays_path
  end

  test "should destroy birthday" do
    assert_difference("Birthday.count", -1) do
      delete birthday_path(@birthday)
    end

    assert_redirected_to birthdays_path
  end
end
