class Admin::InstructorProfilesController < Admin::ControllerBase
  def index
    @instructor_profiles = InstructorProfile.order(:profile_path).decorate
    @count = @instructor_profiles.count
  end
end
