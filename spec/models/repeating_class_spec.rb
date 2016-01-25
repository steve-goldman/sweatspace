require 'rails_helper'

RSpec.describe RepeatingClass, :type => :model do
  before { Timecop.freeze 100.years.ago }

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

  describe ".create_classes!" do
    subject { FactoryGirl.create :repeating_class }
    let(:future_dates) { [ "2016-01-25", "2016-02-01", "2016-02-08" ] }
    before { allow(subject).to receive(:future_dates).and_return(future_dates) }

    it "creates 3 classes" do
      expect { subject.create_classes! }.to change(Clazz, :count).by(3)
    end

    it "creates with the correct dates" do
      subject.create_classes!
      future_dates.each do |future_date|
        expect(subject.classes.confirmed.find_by(date: future_date)).to be
      end
    end
  end
end
