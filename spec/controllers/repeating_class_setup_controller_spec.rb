require "rails_helper"

RSpec.describe RepeatingClassSetupController, type: :controller do
  render_views
  before { login_instructor_user }
  before { Timecop.freeze 100.years.ago }

  let(:class_template) do
    FactoryGirl.create :class_template
  end

  describe "POST :start" do
    def create_clazz confirmed
      FactoryGirl.create :clazz,
                         confirmed: confirmed,
                         class_template: class_template,
                         instructor_profile: @user.instructor_profile,
                         repeating_class: repeating_class
    end

    let(:clazz) { create_clazz true }
    let(:unconfirmed_clazz) { create_clazz false }

    before { clazz.repeating_class = nil }

    it "creates a repeating class" do
      expect { post :start, class_id: clazz.id }.to change(RepeatingClass, :count).by(1)
    end

    it "redirects to the first step" do
      post :start, class_id: clazz.id
      expect(response).to redirect_to(repeating_class_repeating_setup_path(clazz.reload.repeating_class.id, :forever))
    end

    it "fails with unconfirmed class" do
      post :start, class_id: unconfirmed_clazz.id
      expect(response).to redirect_to(classes_path)
    end
  end

  def create_repeating_class confirmed
    FactoryGirl.create :repeating_class,
                       confirmed: confirmed,
                       class_template: class_template,
                       instructor_profile: @user.instructor_profile
  end

  let(:repeating_class) { create_repeating_class false }
  let(:confirmed_repeating_class) { create_repeating_class true }

  before { allow_any_instance_of(RepeatingClass).to receive(:classes).and_return([OpenStruct.new(id: 1)]) }

  describe "GET :forever" do
    it "renders the view" do
      get :show, repeating_class_id: repeating_class.id, id: :forever
      expect(response).to render_template(:forever)
    end

    it "fails with confirmed repeating class" do
      get :show, repeating_class_id: confirmed_repeating_class.id, id: :forever
      expect(response).to redirect_to(classes_path)
    end
  end

  describe "GET :number_of_weeks" do
    context "not forever" do
      it "renders the view" do
        get :show, repeating_class_id: repeating_class.id, id: :number_of_weeks
        expect(response).to render_template(:number_of_weeks)
      end

      it "fails with confirmed repeating class" do
        get :show, repeating_class_id: confirmed_repeating_class.id, id: :number_of_weeks
        expect(response).to redirect_to(classes_path)
      end
    end
  end

  describe "GET :confirm" do
    it "renders the view" do
      get :show, repeating_class_id: repeating_class.id, id: :confirm
      expect(response).to render_template(:confirm)
    end

    it "fails with confirmed repeating class" do
      get :show, repeating_class_id: confirmed_repeating_class.id, id: :confirm
      expect(response).to redirect_to(classes_path)
    end
  end
end
