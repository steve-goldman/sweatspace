class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :logged_in?

  def instagram
    sign_in_and_redirect User.from_omniauth(request.env["omniauth.auth"])
  end

  def failure
    redirect_to root_path
  end
end
