FactoryGirl.define do
  factory :class_template do
    name "The Best Class Name"
    description "The best class description."
    duration 60
    association :studio_brand
  end
end
