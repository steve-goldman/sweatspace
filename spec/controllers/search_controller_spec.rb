require "rails_helper"

RSpec.describe SearchController, type: :controller do
  describe "GET :show" do
    it "renders the template" do
      get :show
      expect(response).to render_template(:show)
    end
  end
end
