require 'rails_helper'

RSpec.describe ClassTemplate, :type => :model do
  it "should have a valid factory" do
    expect(FactoryGirl.build(:class_template)).to be_valid
  end

  describe "associations" do
    it { should belong_to :instructor_profile }
    it { should belong_to :clazz_type }
    it { should belong_to :studio }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :duration }
  end
end
