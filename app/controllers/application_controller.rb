class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in?
  before_action :authenticate_email, if: "user_signed_in?"

  def authenticate_email
    unless current_user.email.present?
      flash[:info] = "Enter your email address to complete your registration"
      redirect_to edit_user_registration_path
    end
  end

  private

  def logged_in?
    unless user_signed_in?
      session["user_return_to"] = request.path
      redirect_to landing_path
    end
  end
end
