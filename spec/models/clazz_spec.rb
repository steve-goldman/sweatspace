require 'rails_helper'

RSpec.describe Clazz, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz)).to be_valid
  end

  describe "associations" do
    it { should belong_to :instructor_profile }
    it { should belong_to :clazz_type }
    it { should belong_to :studio }
  end

  describe "validations" do
    it { should validate_presence_of :time }
    it { should validate_presence_of :duration }
  end
end
