require "rails_helper"

RSpec.describe InstructorProfilesController, type: :controller do
  render_views
  before { login_user }

  let(:instance) { FactoryGirl.create :instructor_profile, user: @user }
  it_behaves_like "a creatable resource"
  it_behaves_like "an updatable resource"
end
