class Admin::GhostingSessionsController < Admin::ControllerBase
  before_action :ghosting_user_id, only: :create
  skip_before_action :authenticate_admin_user!, only: :destroy

  def create
    cookies[:ghosting_user_id] = @ghosting_user_id
    redirect_to root_path
  end

  def destroy
    cookies.delete :ghosting_user_id
    redirect_to admin_instructor_profiles_path
  end

  private

  def ghosting_user_id
    @ghosting_user_id = params[:ghosting_session].try(:[], :user_id)
    if @ghosting_user_id.nil?
      flash[:danger] = "Something went wrong: no user_id"
      redirect_to admin_instructor_profiles_path
    end
  end
end
