require "rails_helper"

RSpec.describe RecurringClassesController, type: :controller do
  render_views
  before { login_instructor_user }
  before { Timecop.freeze 100.years.ago }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"

  let(:recurring_class) do
    FactoryGirl.create :recurring_class, instructor_profile: @user.instructor_profile
  end

  let(:attributes) do
    FactoryGirl.build(:recurring_class, instructor_profile: @user.instructor_profile).attributes
  end

  let(:controller_recurring_class) do
    controller.instance_variable_get :@recurring_class
  end

  describe "POST :create" do
    context "SUCCESS" do
      def do_action
        post :create, recurring_class: attributes
      end

      it "redirects on success" do
        do_action
        expect(response).to redirect_to(confirm_recurring_class_path(id: controller_recurring_class.id))
      end

      it "creates a database record" do
        expect { do_action }.to change { RecurringClass.unconfirmed.count }.by(1)
      end
    end
  end

  describe "GET :edit" do
    def do_action
      get :edit, id: recurring_class.id
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
      patch :update, id: recurring_class.id, recurring_class: attributes
    end

    context "SUCCESS" do
      it "redirects on success" do
        do_action
        expect(response).to redirect_to(confirm_recurring_class_path(recurring_class.id))
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
      get :confirm, id: recurring_class.id
    end

    context "SUCCESS" do
      it "renders the template" do
        do_action
        expect(response).to render_template(:confirm)
      end
    end

    context "FAILURE" do
      context "bogus id" do
        it "redirects to root" do
          get :confirm, id: 999999
          expect(response).to redirect_to(root_path)
        end
      end

      context "incomplete record" do
        before do
          recurring_class.update_attributes first_date: nil,
                                            time_of_day: nil
        end

        it "renders the template" do
          get :confirm, id: recurring_class.id
          expect(response).to render_template(:confirm)
        end
      end
    end
  end

  describe "PATCH :confirmed" do
    def do_action
      patch :confirmed, id: recurring_class.id
    end

    context "SUCCESS" do
      it "redirects to classes index" do
        do_action
        expect(response).to redirect_to(profile_path(@user.instructor_profile.profile_path))
      end

      it "adds a confirmed class" do
        expect { do_action }.to change { RecurringClass.confirmed.count }.by(1)
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
