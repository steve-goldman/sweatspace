class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_email, only: :destroy
end
