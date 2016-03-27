class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :use_ssl?

  before_action :navbar

  alias_method :devise_current_user, :current_user

  def current_user
    @current_user ||=
      if devise_current_user.try(:admin?) && cookies[:ghosting_user_id]
        @ghosting = true
        User.find cookies[:ghosting_user_id].to_i
      else
        devise_current_user
      end
  end

  def ghosting?
    @ghosting == true
  end

  helper_method :ghosting?

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
  end
end
