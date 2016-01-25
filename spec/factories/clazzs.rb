FactoryGirl.define do
  factory :clazz do
    association :instructor_profile
    association :class_template
    association :studio
    date "2016-01-24"
    time_of_day "05:49 PM"

    factory :confirmed_clazz, class: "Clazz" do
      confirmed true
    end
  end
end
