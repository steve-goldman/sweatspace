require 'rails_helper'

RSpec.describe Studio, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:studio)).to be_valid
  end

  describe "associations" do
    it { should have_many :classes }
    it { should have_many :class_template_studios }
    it { should have_many :class_templates }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :url }
    it { should validate_presence_of :map_url }
    it { should validate_presence_of :timezone }
  end
end
