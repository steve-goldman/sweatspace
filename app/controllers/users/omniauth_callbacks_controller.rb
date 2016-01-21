class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :logged_in?
  skip_before_action :valid_access_token?

  def instagram
    auth = request.env["omniauth.auth"]
    session["access_token"] = auth.credentials.token
    sign_in_and_redirect User.from_omniauth(auth)
  end

  def failure
    redirect_to root_path
  end
end
