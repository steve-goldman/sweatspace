require 'rails_helper'

RSpec.describe InstructorProfile, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:instructor_profile)).to be_valid
  end

  describe "validations" do
    subject { FactoryGirl.build :instructor_profile }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of :profile_path }
  end

  describe "associations" do
    it { should belong_to :user }
  end
end
