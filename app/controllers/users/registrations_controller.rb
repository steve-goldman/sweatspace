class Users::RegistrationsController < Devise::RegistrationsController
  before_action :has_invitation, only: [:new, :create]

  def create
    super
    if create_succeeded?
      @invitation.accepted! self.resource, Time.current
    end
  end

  def update_resource resource, params
    resource.update_without_password params
  end

  private

  def create_succeeded?
    self.resource.persisted?
  end

  def has_invitation
    @invitation = Invitation.not_accepted.find_by token: params[:token]
    if @invitation.nil?
      redirect_to root_path
    end
  end

  def sign_up_params
    params.require(resource_name).permit(User::PERMITTED_PARAMS)
  end
end
