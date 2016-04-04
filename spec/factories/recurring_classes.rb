FactoryGirl.define do
  factory :recurring_class do
    day_of_week 2
    first_date "2016-02-02"
    time_of_day "12:00 PM"
    number_of_weeks 4
    duration 60
    association :class_template
    association :studio
    association :instructor_profile
  end
end
