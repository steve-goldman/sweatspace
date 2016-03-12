class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def user_has_profile
    if current_user.instructor_profile.nil?
      redirect_to root_path
    end
  end

  def user_does_not_have_profile
    unless current_user.instructor_profile.nil?
      redirect_to root_path
    end
  end

  def after_sign_in_path_for resource
    if current_user.instructor_profile
      profile_path current_user.instructor_profile.profile_path
    else
      root_path
    end
  end
end
