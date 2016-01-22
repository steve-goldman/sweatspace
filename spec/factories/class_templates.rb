FactoryGirl.define do
  factory :class_template do
    association :clazz_type
    name "The Best Class Name"
    description "The best class description."
    duration 60
  end
end
