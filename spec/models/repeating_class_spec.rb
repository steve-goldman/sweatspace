require 'rails_helper'

RSpec.describe RepeatingClass, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz)).to be_valid
  end

  describe "associations" do
    it { should belong_to :instructor_profile }
    it { should belong_to :class_template }
    it { should belong_to :studio }
    it { should have_many :classes }
  end

  describe "validations" do
    it { should validate_presence_of :day_of_week }
    it { should validate_presence_of :time_of_day }
    it { should_not allow_value(0).for(:number_of_weeks) }
    it { should allow_value(1).for(:number_of_weeks) }
    it { should allow_value(12).for(:number_of_weeks) }
    it { should_not allow_value(13).for(:number_of_weeks) }
  end
end