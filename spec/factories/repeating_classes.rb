FactoryGirl.define do
  factory :repeating_class do
    day_of_week 2
    time_of_day "12:00 PM"
    number_of_weeks 4
    association :class_template
    association :studio
    association :instructor_profile
  end
end
