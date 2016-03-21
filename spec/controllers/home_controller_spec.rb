require "rails_helper"

RSpec.describe HomeController do
  render_views

  describe "GET :faq" do
    it "renders the view" do
      get :faq
      expect(response).to render_template(:faq)
    end
  end
end
