require "test_helper"

class ActivityTest < ActiveSupport::TestCase

  test "new activity inserts correctly" do
    activity = Activity.new(
      user_id: 1,
      weight: 100,
      date: '2021-02-10 23:38:17',
      time: 120,
      distance: 10,
      kcal: 1051.2471600000001
    )

    assert(activity.save, "Could not save activity")

    latest = Activity.where(user_id: 1).order("created_at").last
    assert_equal(latest, activity, "Entity saved not equal to entity found")
  end

  test "new activity fails with incomplete data" do
    activity = Activity.new(
      user_id: 1,
      date: '2021-02-10 23:38:17',
      time: 120,
      distance: 10,
      kcal: 1051.2471600000001
    )

    assert_not(activity.save, "Activity should not be saved")
    assert_equal(
      ["Weight can't be blank", "Weight is not a number"],
      activity.errors.full_messages,
      "Error message is incorrect"
    )
  end

  test "new activity fails with bad data" do
    activity = Activity.new(
      user_id: 1,
      weight: -100,
      date: '2021-02-10 23:38:17',
      time: "120",
      distance: 10,
      kcal: 1051.2471600000001
    )

    assert_not(activity.save, "Activity should not be saved")
    assert_equal(
      ["Weight must be greater than or equal to 0", "Kcal must be greater than or equal to 0"],
      activity.errors.full_messages,
      "Error message is incorrect"
    )
  end

  test "new activity fails with no assoc user" do
    activity = Activity.new(
      user_id: 100,
      weight: 100,
      date: '2021-02-10 23:38:17',
      time: 120,
      distance: 10,
      kcal: 1051.2471600000001
    )

    assert_not(activity.save, "Activity should not be saved")
    assert_equal(
      ["User must exist", "User can't be blank"],
      activity.errors.full_messages,
      "Error message is incorrect"
    )
  end

  test "calculations are correct" do
    activity = Activity.new(
      user_id: 1,
      weight: 100,
      date: '2021-02-10 23:38:17',
      time: 120,
      distance: 10,
    )

    assert(activity.save, "Could not save activity")
    assert_equal(1051.2471600000001, activity.kcal, "End calculation result is incorrect")
  end

  test "update existing records" do
    # Check fixture value is reading correctly
    assert_equal(activities(:one).kcal, 5, "Fixture kcal value is incorrect")
    # Update Kcal
    Activity.updateCaloriesBurned()
    # Check for updated value
    assert_equal(789.466176, Activity.find(activities(:one).id).kcal, "Updated kcal value is incorrect")
  end
end
