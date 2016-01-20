FactoryGirl.define do
  factory :class_template do
    association :instructor_profile
    association :clazz_type
    association :studio
    name "The Best Class Name"
    description "The best class description."
    duration 60
  end
end
