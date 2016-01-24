FactoryGirl.define do
  factory :repeating_class do
    day_of_week "Tuesday"
    time_of_day "12:00"
    association :class_template
    association :studio
    association :instructor_profile
  end
end
