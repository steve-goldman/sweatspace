require 'rails_helper'

RSpec.describe InstructorProfile, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:instructor_profile)).to be_valid
  end

  describe "validations" do
    subject { FactoryGirl.build :instructor_profile }

    context "profile_path" do
      it { should validate_presence_of :profile_path }
      it { should validate_uniqueness_of :profile_path }

      it "should allow lowercase" do
        subject.profile_path = "a"
        expect(subject).to be_valid
      end

      it "should allow uppercase" do
        subject.profile_path = "A"
        expect(subject).to be_valid
      end

      it "should allow numeral" do
        subject.profile_path = "1"
        expect(subject).to be_valid
      end

      it "should allow dash in between" do
        subject.profile_path = "a-A-1"
        expect(subject).to be_valid
      end

      it "should not allow dash at beginning" do
        subject.profile_path = "-A"
        expect(subject).to_not be_valid
      end

      it "should not allow dash at end" do
        subject.profile_path = "A-"
        expect(subject).to_not be_valid
      end
    end
  end

  describe "associations" do
    it { should belong_to :user }
    it { should have_many :classes }
    it { should have_many :recurring_classes }
    it { should have_many :class_templates }
  end
end
