FactoryGirl.define do
  factory :clazz do
    association :instructor_profile
    association :studio
    time "2016-01-13 15:32:56"
    duration 90
    name "The best class"
  end
end
