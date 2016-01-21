class HomeController < ApplicationController
  skip_before_action :logged_in?, only: :landing
  skip_before_action :valid_access_token?, only: :landing
  layout "landing", only: :landing

  def dashboard
  end

  def landing
  end
end
