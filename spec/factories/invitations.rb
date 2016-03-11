FactoryGirl.define do
  factory :invitation do
    token "MyString"
    invited_email "user@email.net"
    accepted_at "2016-03-11 11:01:26"
    association :user
  end
end
