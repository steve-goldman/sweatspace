def login_user
  login FactoryGirl.create(:user)
end

def login_admin_user
  login FactoryGirl.create(:admin_user)
end

def login user
  @request.env["devise.mapping"] = Devise.mappings[:user]
  @user = user
  sign_in @user
  allow(InstagramService.instance).to receive(:valid_access_token?).and_return(true)
end
