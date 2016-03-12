FactoryGirl.define do
  factory :instructor_profile do
    association :user
    profile_path "first-last"
  end
end
