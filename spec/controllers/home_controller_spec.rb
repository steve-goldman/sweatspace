require "rails_helper"

RSpec.describe HomeController do
  render_views

  describe "GET :dashboard" do
    it "renders the view" do
      get :dashboard
      expect(response).to render_template(:dashboard)
    end
  end
end
