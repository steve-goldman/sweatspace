FactoryGirl.define do
  factory :user, class: "User" do
    email { Faker::Internet.email }
    name "Steve Goldman"
    nickname "discgolfstu"
    image "some-image"
    password "password"
    password_confirmation "password"
  end
end
