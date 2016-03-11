require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:invitation)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:invited_email) }
    it { should_not validate_presence_of(:user_id) }

    context "accepted" do
      before { subject.accepted_at = nil }
      it { should_not validate_presence_of(:user_id) }
    end
  end
end
