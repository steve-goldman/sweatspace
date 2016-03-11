FactoryGirl.define do
  factory :invitation do
    token "MyString"
    invited_email "user@email.net"

    factory :not_accepted_invitation, class: "Invitation" do
    end

    factory :accepted_invitation, class: "Invitation" do
      accepted_at { Time.current }
      association :user
    end
  end
end
