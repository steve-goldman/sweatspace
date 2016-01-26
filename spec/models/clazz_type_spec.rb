require 'rails_helper'

RSpec.describe ClazzType, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz_type)).to be_valid
  end

  describe "associations" do
    it { should have_many :class_template_class_types }
    it { should have_many :class_templates }
  end

  describe "validations" do
    subject { FactoryGirl.build :clazz_type }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end
