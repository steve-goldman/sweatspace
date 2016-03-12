require "rails_helper"

RSpec.describe InstructorProfilesController, type: :controller do
  render_views

  it_behaves_like "a showable resource", InstructorProfile,
                  id_field: :profile_path

  context "user without a profile" do
    before { login_user }
    it_behaves_like "a newable resource"
    it_behaves_like "a creatable resource", InstructorProfile, {}
  end

  context "user with a profile" do
    before { login_instructor_user }
    it_behaves_like "an editable resource", InstructorProfile,
                    before_actions: [:owns_instructor_profile]
    it_behaves_like "an updatable resource", InstructorProfile,
                    before_actions: [:owns_instructor_profile],
                    success_path: :root_path
  end
end
