require "rails_helper"

RSpec.describe ClassesController, type: :controller do
  render_views
  before { login_instructor_user }

  describe "GET :index" do
    it "renders the view" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
