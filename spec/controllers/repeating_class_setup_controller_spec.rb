require "rails_helper"

RSpec.describe RepeatingClassSetupController, type: :controller do
  render_views
  before { login_instructor_user }

  let(:class_template) do
    FactoryGirl.create :class_template
  end

  let(:repeating_class) do
    FactoryGirl.create :repeating_class,
                       class_template: class_template,
                       instructor_profile: @user.instructor_profile
  end

  def create_clazz confirmed
    FactoryGirl.create :clazz,
                       confirmed: confirmed,
                       class_template: class_template,
                       instructor_profile: @user.instructor_profile,
                       repeating_class: repeating_class
  end

  let(:clazz) { create_clazz true }
  let(:unconfirmed_clazz) { create_clazz false }

  describe "POST :start" do
    before { clazz.repeating_class = nil }

    it "creates a repeating class" do
      expect { post :start, class_id: clazz.id }.to change(RepeatingClass, :count).by(1)
    end

    it "redirects to the first step" do
      post :start, class_id: clazz.id
      expect(response).to redirect_to(class_repeating_setup_path(clazz.id, :forever))
    end

    it "fails with unconfirmed class" do
      post :start, class_id: unconfirmed_clazz.id
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :forever" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :forever
      expect(response).to render_template(:forever)
    end

    it "fails with unconfirmed class" do
      get :show, class_id: unconfirmed_clazz.id, id: :forever
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :number_of_weeks" do
    context "not forever" do
      it "renders the view" do
        get :show, class_id: clazz.id, id: :number_of_weeks
        expect(response).to render_template(:number_of_weeks)
      end

      it "fails with unconfirmed class" do
        get :show, class_id: unconfirmed_clazz.id, id: :number_of_weeks
        expect(response).to redirect_to(classes_path)
      end
    end
  end

  describe "GET :confirm" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :confirm
      expect(response).to render_template(:confirm)
    end

    it "fails with unconfirmed class" do
      get :show, class_id: unconfirmed_clazz.id, id: :confirm
      expect(response).to redirect_to(classes_path)
    end
  end
end
