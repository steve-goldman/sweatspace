FactoryGirl.define do
  factory :instructor_profile do
    association :user
    profile_path { UUIDTools::UUID.random_create.to_s }
  end
end
