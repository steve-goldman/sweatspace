FactoryGirl.define do
  factory :class_template_studio do
    association :class_template
    association :studio
  end
end
