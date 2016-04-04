require 'rails_helper'

RSpec.describe Clazz, :type => :model do
  before { Timecop.freeze 100.years.ago }
  after { Timecop.return }

  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz)).to be_valid
  end

  describe "associations" do
    it { should belong_to :instructor_profile }
    it { should belong_to :class_template }
    it { should belong_to :studio }
    it { should belong_to :recurring_class }
  end

  describe "validations" do
    it { should validate_presence_of :instructor_profile }
    it { should validate_presence_of :class_template }
    it { should validate_presence_of :studio }
    it { should validate_presence_of :duration }
    it { should allow_value("2016-01-24").for(:date) }
    it { should allow_value("05:31 PM").for(:time_of_day) }
  end

  let(:studio) { FactoryGirl.build :studio, timezone: "Pacific Time (US & Canada)" }
  let(:clazz) { FactoryGirl.create :clazz, date: "2016-01-24", time_of_day: "02:39 PM", studio: studio }

  describe "timestamp" do
    it "sets correctly" do
      expect(clazz.timestamp.to_i).to eq(1453675140)
    end
  end
end
