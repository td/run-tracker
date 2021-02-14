# RunTracker
###### PD Coding Challenge

This is a run tracking app which allows users to create an account, input their running data and view their running history along with calculated calories burned on those runs.

  - Ruby 2.6.3p62
  - Rails 6.1.1
  - Devise 4.7.3


### Deployment
 1. Download / Pull repo `git clone git@github.com:td/run-tracker.git run-tracker`
 2. Navigate into the project `cd run-tracker`
 3. Run package installer `bundler install`
 4. Create DB and Migrate `rails db:create && rails db:migrate`
 5. Install Webpacker `rails webpacker:install` select `n` on overwrite prompt
 6. Launch server `rails server`
 7. Goto <a href="http://localhost:3000">localhost:3000</a>

### Re-calculate existing data
From the project folder, run `rails runner "Activity.updateCaloriesBurned"`
### Testing
`rails test`
