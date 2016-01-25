require "rails_helper"

RSpec.describe ClassSetupController, type: :controller do
  render_views
  before { login_instructor_user }

  describe "POST :start" do
    it "creates a class" do
      expect { post :start }.to change(Clazz, :count).by(1)
    end

    it "redirects to the first step" do
      post :start
      expect(response).to redirect_to(class_setup_path(Clazz.last.id, :class_template))
    end
  end

  describe "POST :finish" do
    it "redirects to classes path" do
      post :finish
      expect(response).to redirect_to(classes_path)
    end
  end

  let(:clazz) { FactoryGirl.create :clazz, instructor_profile: @user.instructor_profile }
  let(:confirmed_clazz) { FactoryGirl.create :confirmed_clazz, instructor_profile: @user.instructor_profile }

  describe "GET :studio" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :studio
      expect(response).to render_template(:studio)
    end

    it "fails with confirmed class" do
      get :show, class_id: confirmed_clazz.id, id: :studio
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :class_template" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :class_template
      expect(response).to render_template(:class_template)
    end

    it "fails with confirmed class" do
      get :show, class_id: confirmed_clazz.id, id: :class_template
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :date" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :date
      expect(response).to render_template(:date)
    end

    it "fails with confirmed class" do
      get :show, class_id: confirmed_clazz.id, id: :date
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :time" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :time
      expect(response).to render_template(:time)
    end

    it "fails with confirmed class" do
      get :show, class_id: confirmed_clazz.id, id: :time
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :confirm" do
    it "renders the view" do
      get :show, class_id: clazz.id, id: :confirm
      expect(response).to render_template(:confirm)
    end

    it "fails with confirmed class" do
      get :show, class_id: confirmed_clazz.id, id: :confirm
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :make_repeating" do
    it "renders the view" do
      get :show, class_id: confirmed_clazz.id, id: :make_repeating
      expect(response).to render_template(:make_repeating)
    end

    it "fails with confirmed repeating class" do
      get :show, class_id: clazz.id, id: :make_repeating
      expect(response).to redirect_to(classes_path)
    end
  end
end
