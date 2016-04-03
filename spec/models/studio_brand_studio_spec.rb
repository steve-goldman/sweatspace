require 'rails_helper'

RSpec.describe StudioBrandStudio, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:studio_brand_studio)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:studio_brand) }
    it { should belong_to(:studio) }
  end

  describe "validations" do
    it { should validate_presence_of(:studio_brand_id) }
    it { should validate_presence_of(:studio_id) }
  end
end
