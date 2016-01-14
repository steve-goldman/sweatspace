class HomeController < ApplicationController
  skip_before_action :logged_in?, only: :landing

  def dashboard
  end

  def landing
  end
end
