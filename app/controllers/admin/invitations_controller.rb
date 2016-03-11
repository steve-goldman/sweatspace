class Admin::InvitationsController < Admin::ControllerBase
  def index
    @invitations = Invitation.all.decorate
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new create_params
    if @invitation.save && @invitation.send_by_mail
      flash[:success] = "Invitation sent"
      redirect_to admin_invitations_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:invitation).permit(Invitation::PERMITTED_PARAMS)
      .merge(token: UUIDTools::UUID.random_create.to_s)
  end
end
