require "rails_helper"

RSpec.describe ClassSetupController, type: :controller do
  render_views
  before { login_instructor_user }

  describe "GET :new" do
    it "redirects to the first step" do
      get :new
      expect(response).to redirect_to(class_setup_path(Clazz.last.id, :class_template))
    end
  end

  let(:clazz) { FactoryGirl.create :clazz, instructor_profile: @user.instructor_profile }

  describe "GET :studio" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :studio
      expect(response).to render_template(:studio)
    end
  end

  describe "GET :class_template" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :class_template
      expect(response).to render_template(:class_template)
    end
  end

  describe "GET :date" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :date
      expect(response).to render_template(:date)
    end
  end

  describe "GET :time" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :time
      expect(response).to render_template(:time)
    end
  end

  describe "GET :confirm" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :confirm
      expect(response).to render_template(:confirm)
    end
  end
end
