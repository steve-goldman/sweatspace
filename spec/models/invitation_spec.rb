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

  describe ".send_by_mail" do
    subject { FactoryGirl.build :invitation }

    let(:mail) { OpenStruct.new(deliver_later: true) }

    before do
      allow(UserMailer).to receive(:invited).with(subject.invited_email, subject.token).and_return(mail)
    end

    it "invokes the mailer" do
      expect(mail).to receive(:deliver_later)
      subject.send_by_mail
    end
  end

  describe ".accepted!" do
    let(:user) { FactoryGirl.create :user }
    let(:accepted_at) { Time.current }

    it "sets accepted_at" do
      expect { subject.accepted! user, accepted_at }.to change(subject, :accepted_at).to(accepted_at)
    end

    it "sets user" do
      expect { subject.accepted! user, accepted_at }.to change(subject, :user_id).to(user.id)
    end
  end
end
