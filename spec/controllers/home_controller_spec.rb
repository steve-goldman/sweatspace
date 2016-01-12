require "rails_helper"

RSpec.describe HomeController do
  render_views

  describe "GET :show" do
    it "renders the view" do
      get :show
      expect(response).to render_template(:show)
    end
  end
end
