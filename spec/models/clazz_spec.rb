require 'rails_helper'

RSpec.describe Clazz, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz)).to be_valid
  end

  describe "associations" do
    it { should belong_to :instructor_profile }
    it { should belong_to :class_template }
    it { should belong_to :studio }
    it { should belong_to :repeating_class }
  end

  describe "validations" do
    context "confirmed" do
      before { allow(subject).to receive(:confirmed?).and_return(true) }
      it { should validate_presence_of :timestamp }
    end

    context "not confirmed" do
      before { allow(subject).to receive(:confirmed?).and_return(false) }
      it { should_not validate_presence_of :timestamp }
    end
  end
end
