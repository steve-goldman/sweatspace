class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :use_ssl?

  before_action :navbar

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

  def after_sign_out_path_for resource
    request.referer || root_path
  end

  private

  def use_ssl?
    Rails.env.production?
  end

  def navbar
    @navbar = NavbarConfig.instance.clear
    @navbar.user = current_user
    @navbar.needs_landing_info = cookies["acked_landing_page_info"].nil?
  end
end
