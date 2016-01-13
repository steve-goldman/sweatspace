require 'rails_helper'

RSpec.describe ClazzType, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:clazz_type)).to be_valid
  end
end
