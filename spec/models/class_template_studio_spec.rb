require 'rails_helper'

RSpec.describe ClassTemplateStudio, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:class_template_studio)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:class_template) }
    it { should belong_to(:studio) }
  end

  describe "validations" do
    it { should validate_presence_of(:class_template_id) }
    it { should validate_presence_of(:studio_id) }
  end
end
