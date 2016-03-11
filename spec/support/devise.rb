def login_user
  login FactoryGirl.create(:user)
end

def login_instructor_user
  login FactoryGirl.create(:instructor_user)
end

def login_admin_user
  login FactoryGirl.create(:admin_user)
end

def set_devise_mappings
  @request.env["devise.mapping"] = Devise.mappings[:user]
end

def login user
  set_devise_mappings
  @user = user
  sign_in @user
end
