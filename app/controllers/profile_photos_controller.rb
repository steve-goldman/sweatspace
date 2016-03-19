class ProfilePhotosController < ApplicationController
  before_action :user_signed_in
  before_action :user_has_profile

  def edit
    @instructor_profile = current_user.instructor_profile
  end
end
