require 'rails_helper'

RSpec.describe NewsletterSignup, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:newsletter_signup)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
  end    
end
