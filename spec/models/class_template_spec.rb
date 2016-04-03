require 'rails_helper'

RSpec.describe ClassTemplate, :type => :model do
  it "should have a valid factory" do
    expect(FactoryGirl.build(:class_template)).to be_valid
  end

  describe "associations" do
    it { should have_many :clazz_types }
    it { should have_many :classes }
    it { should belong_to :studio_brand }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :studio_brand_id }
  end
end
