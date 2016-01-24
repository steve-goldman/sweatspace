FactoryGirl.define do
  factory :repeating_class do
    day_of_week "Tuesday"
    time { Time.parse("12:00") }
    association :class_template
    association :studio_id
    association :instructor_profile
  end
end
