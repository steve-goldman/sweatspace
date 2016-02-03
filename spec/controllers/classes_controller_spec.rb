require "rails_helper"

RSpec.describe ClassesController, type: :controller do
  render_views
  before { login_instructor_user }
  before { Timecop.freeze 100.years.ago }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"

  let(:clazz) do
    FactoryGirl.create :clazz, instructor_profile: @user.instructor_profile
  end

  let(:attributes) do
    FactoryGirl.build(:clazz, instructor_profile: @user.instructor_profile).attributes
  end

  let(:controller_clazz) do
    controller.instance_variable_get :@clazz
  end

  describe "POST :create" do
    context "SUCCESS" do
      def do_action
        post :create, clazz: attributes
      end

      it "redirects on success" do
        do_action
        expect(response).to redirect_to(confirm_class_path(id: controller_clazz.id))
      end

      it "creates a database record" do
        expect { do_action }.to change { Clazz.unconfirmed.count }.by(1)
      end
    end
  end

  describe "GET :edit" do
    def do_action
      get :edit, id: clazz.id
    end

    context "SUCCESS" do
      it "renders the view" do
        do_action
        expect(response).to render_template(:edit)
      end
    end

    context "FAILURE" do
      it "redirects to root" do
        get :edit, id: 999999
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH :update" do
    def do_action
      patch :update, id: clazz.id, clazz: attributes
    end

    context "SUCCESS" do
      it "redirects on success" do
        do_action
        expect(response).to redirect_to(confirm_class_path(clazz.id))
      end
    end

    context "FAILURE" do
      it "redirects to root" do
        patch :update, id: 999999
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET :confirm" do
    def do_action
      get :confirm, id: clazz.id
    end

    context "SUCCESS" do
      it "renders the template" do
        do_action
        expect(response).to render_template(:confirm)
      end
    end

    context "FAILURE" do
      it "redirects to root" do
        get :confirm, id: 999999
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH :confirmed" do
    def do_action
      patch :confirmed, id: clazz.id
    end

    context "SUCCESS" do
      it "redirects to classes index" do
        do_action
        expect(response).to redirect_to(classes_path)
      end

      it "adds a confirmed class" do
        expect { do_action }.to change { Clazz.confirmed.count }.by(1)
      end
    end

    context "FAILURE" do
      it "redirects to root" do
        patch :confirmed, id: 999999
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
