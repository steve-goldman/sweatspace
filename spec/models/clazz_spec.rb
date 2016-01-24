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
    it { should allow_value("2016-01-24").for(:date) }
    it { should allow_value("").for(:date) }
    it { should allow_value("05:31 PM").for(:time_of_day) }
    it { should allow_value("").for(:time_of_day) }
  end

  let(:studio) { FactoryGirl.build :studio, timezone: "Pacific Time (US & Canada)" }
  let(:clazz) { FactoryGirl.create :clazz, date: "2016-01-24", time_of_day: "02:39 PM", studio: studio }

  describe "timestamp" do
    it "sets correctly" do
      expect(clazz.timestamp.to_i).to eq(1453675140)
    end
  end
end
