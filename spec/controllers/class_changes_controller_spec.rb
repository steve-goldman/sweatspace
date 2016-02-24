require "rails_helper"

RSpec.describe ClassChangesController, type: :controller do
  render_views
  before { login_instructor_user }
  before { Timecop.freeze 100.years.ago }
  after { Timecop.return }

  let(:clazz) { FactoryGirl.create :confirmed_clazz, instructor_profile: @user.instructor_profile }

  describe "POST :cancel" do
    context "for a not canceled class" do
      it "redirects to the classes path" do
        post :cancel, class_id: clazz.id
        expect(response).to redirect_to(class_path(clazz))
      end
    end

    context "for a canceled class" do
      before { clazz.update_attributes canceled: true }

      it "redirects to the root path" do
        post :cancel, class_id: clazz.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST :uncancel" do
    context "for a canceled class" do
      before { clazz.update_attributes canceled: true }

      it "redirects to the classes path" do
        post :uncancel, class_id: clazz.id
        expect(response).to redirect_to(class_path(clazz))
      end
    end

    context "for a not canceled class" do
      it "redirects to the rooth path" do
        post :uncancel, class_id: clazz.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST :substitute" do
    context "for a not substituted class" do
      it "redirects to the classes path" do
        post :substitute, class_id: clazz.id
        expect(response).to redirect_to(class_path(clazz))
      end
    end

    context "for a substituted class" do
      before { clazz.update_attributes substituted: true }

      it "redirects to the root path" do
        post :substitute, class_id: clazz.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST :unsubstitute" do
    context "for a substituted class" do
      before { clazz.update_attributes substituted: true }

      it "redirects to the classes path" do
        post :unsubstitute, class_id: clazz.id
        expect(response).to redirect_to(class_path(clazz))
      end
    end

    context "for a not substituted class" do
      it "redirects to the rooth path" do
        post :unsubstitute, class_id: clazz.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST :delete" do
    it "redirects to the classes path" do
      post :delete, class_id: clazz.id
      expect(response).to redirect_to(profile_path(@user.instructor_profile.profile_path))
    end

    it "removes a class" do
      expect { post :cancel, class_id: clazz.id }.to change(Clazz, :count).by(1)
    end
  end

  describe "POST :last_in_repating_class" do
    before { clazz.update_attributes recurring_class: FactoryGirl.create(:recurring_class,
                                                                         instructor_profile: @user.instructor_profile) }


  end
end
