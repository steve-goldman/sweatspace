require "rails_helper"

RSpec.describe Admin::ClassTemplateClassTypesController, type: :controller do
  render_views
  before { login_admin_user }

  describe "POST :create" do
    let(:class_template) { FactoryGirl.create :class_template }

    context "with proper params" do
      def do_action
        post :create, class_template_class_type: { class_template_id: class_template.id, clazz_type_id: 1 }
      end

      it "redirects to edit class template" do
        do_action
        expect(response).to redirect_to(edit_admin_class_template_path(class_template))
      end

      it "adds a class_template_class_type" do
        expect { do_action }.to change(ClassTemplateClassType, :count).by(1)
      end
    end

    context "with improper params" do
      def do_action
        post :create, class_template_class_type: { class_template_id: class_template.id }
      end

      it "redirects to root path" do
        do_action
        expect(response).to redirect_to(root_path)
      end

      it "does not add a class_template_class_type" do
        expect { do_action }.to_not change(ClassTemplateClassType, :count)
      end
    end
  end

  describe "DELETE :destroy" do
    let!(:class_template_class_type) { FactoryGirl.create :class_template_class_type }

    def do_action
      delete :destroy, id: class_template_class_type
    end

    it "redirects to edit class template" do
      do_action
      expect(response).to redirect_to(edit_admin_class_template_path(class_template_class_type.class_template))
    end

    it "removes a class_template_class_type" do
      expect { do_action }.to change(ClassTemplateClassType, :count).by(-1)
    end
  end
end
