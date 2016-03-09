FactoryGirl.define do
  factory :instructor_profile do
    association :user
    first_name "first-name"
    last_name "last-name"
    profile_path "first-last"
  end
end
