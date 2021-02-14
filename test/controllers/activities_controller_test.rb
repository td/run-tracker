require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "main page renders with correct data" do
    sign_in users(:one)
    get root_path

    assert_response(:success, "Response not as expected")
    assert_select("h2", "Test User", "Incorrect user's name found")
  end

  test "new activity form posts" do
    sign_in users(:one)
    post '/activities', params: { activity: {
      weight: 999,
      date: '2021-02-10 23:38:17',
      time: 120,
      distance: 10
    }}

    assert_response(:redirect, "Response not as expected")
    assert_equal(999, Activity.where(user_id: 1).order("created_at").last.weight, "Latest entity does not match one submitted")
  end

  test "user bounceback with no sign in" do
    get root_path

    assert_response(:redirect, "Response not as expected")
    assert_redirected_to({controller: "devise/sessions", action: "new"}, "User not redirected to login")
  end
end
