class Activity < ApplicationRecord
    belongs_to :user

    validates :user, :user_id, :distance, :time, :weight, :date, :kcal, presence: true
    validates :user_id, :distance, :time, :weight, :kcal, numericality: { only_float: true, greater_than_or_equal_to: 0}

    before_validation(on: :create) do
        if (!self.time.nil? && !self.distance.nil? && !self.weight.nil?)
            self.kcal = self.calculateKcal()
        end
    end

    def calculateKcal()
        vo2 = calculateVO2(calculateKph()) / 1000
        kcal_per_min = 4.86 * self.weight * vo2
        kcal_burned = kcal_per_min * self.time

        return kcal_burned
    end

    def self.updateCaloriesBurned
        all_activities = Activity.all

        all_activities.each do |activity|
            puts "Updating #{activity.id}"
            activity.kcal = activity.calculateKcal()

            if !activity.save
                puts "Could not update #{activity.id}"
            end
        end
    end

    private

    def calculateVO2(kph)
        # VO2 Max calculation
        return 2.209 + 3.1633 * kph
    end

    def calculateKph()
        return self.distance / self.time * 60
    end
end
