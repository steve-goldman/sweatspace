require "rails_helper"

RSpec.describe Admin::StudioBrandStudiosController, type: :controller do
  render_views
  before { login_admin_user }

  describe "POST :create" do
    let(:studio_brand) { FactoryGirl.create :studio_brand }

    context "with proper params" do
      def do_action
        post :create, studio_brand_studio: { studio_brand_id: studio_brand.id, studio_id: 1 }
      end

      it "redirects to edit studio brand" do
        do_action
        expect(response).to redirect_to(edit_admin_studio_brand_path(studio_brand))
      end

      it "adds a studio_brand_studio" do
        expect { do_action }.to change(StudioBrandStudio, :count).by(1)
      end
    end

    context "with improper params" do
      def do_action
        post :create, studio_brand_studio: { studio_brand_id: studio_brand.id }
      end

      it "redirects to root path" do
        do_action
        expect(response).to redirect_to(root_path)
      end

      it "does not add a studio_brand_studio" do
        expect { do_action }.to_not change(StudioBrandStudio, :count)
      end
    end
  end

  describe "DELETE :destroy" do
    let!(:studio_brand_studio) { FactoryGirl.create :studio_brand_studio }

    def do_action
      delete :destroy, id: studio_brand_studio
    end

    it "redirects to edit studio brand" do
      do_action
      expect(response).to redirect_to(edit_admin_studio_brand_path(studio_brand_studio.studio_brand))
    end

    it "removes a studio_brand_studio" do
      expect { do_action }.to change(StudioBrandStudio, :count).by(-1)
    end
  end
end
