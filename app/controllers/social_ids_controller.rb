class SocialIdsController < ApplicationController
  before_action :user_signed_in
  before_action :user_has_profile

  def edit
    NavbarConfig.instance.back_link = profile_path current_user.instructor_profile.profile_path
    @instructor_profile = current_user.instructor_profile.decorate
  end
end
