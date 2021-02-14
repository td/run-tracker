require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user can signup" do
    user = User.new(
      email: "test_one@email.com",
      password: "hello123",
      name: "Test User",
      photo_url: "https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697"
    )

    assert(user.save, "Could not save user")

    latest = User.order("created_at").last
    assert_equal(user, latest, "Entity saved not equal to entity found")
  end

  test "signup fails with missing data" do
    user = User.new(
      email: "test@email",
      password: "hell011",
      photo_url: "https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697"
    )

    assert_not(user.save, "User should not be saved")

    latest = User.order("created_at").last
    assert_equal(
      ["Name can't be blank"],
      user.errors.full_messages,
      "Error message is incorrect"
    )
  end

  test "signup fails with bad data" do
    user = User.new(
      email: "garry",
      password: "hello",
      name: "Test User",
      photo_url: "https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697"
    )

    assert_not(user.save, "User should not be saved")

    latest = User.order("created_at").last
    assert_equal(
      ["Email is invalid", "Password is too short (minimum is 6 characters)"],
      user.errors.full_messages,
      "Error message is incorrect"
    )
  end
end
