require "rails_helper"

RSpec.describe HomeController do
  render_views

  describe "GET :landing" do
    it "renders the view" do
      get :landing
      expect(response).to render_template(:landing)
    end
  end
end
