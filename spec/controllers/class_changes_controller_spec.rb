require "rails_helper"

RSpec.describe ClassChangesController, type: :controller do
  render_views
  before { login_instructor_user }
  before { Timecop.freeze 100.years.ago }

  let(:clazz) { FactoryGirl.create :confirmed_clazz, instructor_profile: @user.instructor_profile }

  describe "GET :show" do
    it "renders the view" do
      xhr :get, :show, class_id: clazz.id, format: :js
      expect(response).to render_template(:show)
    end
  end

  describe "POST :cancel" do

  end

  describe "POST :delete" do

  end

  describe "POST :last_in_repating_group" do

  end
end
