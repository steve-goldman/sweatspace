class Admin::ControllerBase < ApplicationController
  before_action :authenticate_admin_user!

  private

  def authenticate_admin_user!
    unless current_user.admin?
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end
