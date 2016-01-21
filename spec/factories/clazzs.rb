FactoryGirl.define do
  factory :clazz do
    association :instructor_profile
    association :class_template
    association :studio
    timestamp "2016-01-13 15:32:56"
  end
end
