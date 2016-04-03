require 'rails_helper'

RSpec.describe StudioBrand, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:studio_brand)).to be_valid
  end

  describe "associations" do
    it { should have_many :studios }
    it { should have_many :class_templates }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :url }
  end
end
