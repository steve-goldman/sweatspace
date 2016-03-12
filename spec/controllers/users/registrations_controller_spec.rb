require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :controller do
  render_views
  before { set_devise_mappings }

  describe "POST :create" do
    let(:invitation) { FactoryGirl.create :not_accepted_invitation, accepted_at: nil, user_id: nil }

    context "SUCCESS" do
      before do
        allow(subject).to receive(:create_succeeded?).and_return(true)
      end

      it "calls accepted! on the invitation" do
        expect_any_instance_of(Invitation).to receive(:accepted!)
        post :create, user: { name: "name" }, token: invitation.token
      end
    end

    context "FAILURE" do
      before do
        allow(subject).to receive(:create_succeeded?).and_return(false)
      end

      it "does not call accepted! on the invitation" do
        expect_any_instance_of(Invitation).to_not receive(:accepted!)
        post :create, user: { name: "name" }, token: invitation.token
      end
    end
  end
end
