require "rails_helper"

RSpec.describe HomeController do
  render_views

  describe "GET :landing" do
    it "renders the view" do
      get :landing
      expect(response).to render_template(:landing)
    end
  end

  describe "GET :dashboard" do
    context "when logged in" do
      before { login_user }

      context "with user with email address" do
        it "renders the view" do
          get :dashboard
          expect(response).to render_template(:dashboard)
        end
      end

      context "with user without email address" do
        before { login FactoryGirl.create(:user, email: nil) }

        it "redirects to edit registration" do
          get :dashboard
          expect(response).to redirect_to(edit_user_registration_path)
        end
      end
    end

    context "when not logged in" do
      it "redirects to landing" do
        get :dashboard
        expect(response).to redirect_to(landing_path)
      end
    end
  end
end
