class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_email, if: "user_signed_in?"

  def authenticate_email
    unless current_user.email.present?
      flash[:info] = "Enter your email address to complete your registration"
      redirect_to edit_registration_path(current_user)
    end
  end
end
