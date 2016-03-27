class InstructorProfile::BaseController < ApplicationController
  before_action :user_signed_in
  before_action :user_has_profile
  before_action :set_back_link

  def edit
    @instructor_profile = current_user.instructor_profile.decorate
  end

  private

  def set_back_link
    NavbarConfig.instance.back_link = profile_path current_user.instructor_profile.profile_path
  end
end
