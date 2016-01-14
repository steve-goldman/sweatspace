class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_email, only: [:edit, :update]

  def update_resource resource, params
    resource.update_without_password params
  end
end
