FactoryGirl.define do
  factory :user, class: "User" do
    email { Faker::Internet.email }
    name "Steve Goldman"
    nickname "discgolfstu"
    image "some-image"
    password "password"
    password_confirmation "password"

    factory :instructor_user, class: "User" do
      association :instructor_profile
    end

    factory :admin_user, class: "User" do
      admin true
    end
  end
end
