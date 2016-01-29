require 'rails_helper'

RSpec.describe ClassTemplateClassType, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:class_template_class_type)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:class_template) }
    it { should belong_to(:clazz_type) }
  end

  describe "validations" do
    it { should validate_presence_of(:class_template_id) }
    it { should validate_presence_of(:clazz_type_id) }
  end
end
