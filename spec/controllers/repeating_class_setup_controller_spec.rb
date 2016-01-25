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

  let(:clazz) do
    FactoryGirl.create :clazz,
                       confirmed: true,
                       class_template: class_template,
                       instructor_profile: @user.instructor_profile,
                       repeating_class: repeating_class
  end

  describe "POST :start" do
    before { clazz.repeating_class = nil }

    it "creates a repeating class" do
      expect { post :start, class_id: clazz.id }.to change(RepeatingClass, :count).by(1)
    end

    it "redirects to the first step" do
      post :start, class_id: clazz.id
      expect(response).to redirect_to(class_repeating_setup_path(clazz.id, :forever))
    end
  end

  describe "GET :forever" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :forever
      expect(response).to render_template(:forever)
    end
  end

  describe "GET :number_of_weeks" do
    context "not forever" do
      it "renders the view" do
        get :show, class_id: clazz.id, id: :number_of_weeks
        expect(response).to render_template(:number_of_weeks)
      end
    end

    context "forever" do
      it "redirects to the next stop" do
        get :show, class_id: clazz.id, id: :number_of_weeks
        
      end
    end
  end

  describe "GET :confirm" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :confirm
      expect(response).to render_template(:confirm)
    end
  end
end
