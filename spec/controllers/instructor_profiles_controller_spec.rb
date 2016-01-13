require "rails_helper"

RSpec.describe InstructorProfilesController, type: :controller do
  render_views
  before { login_user }

  describe "GET :new" do
    it "renders the view" do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
