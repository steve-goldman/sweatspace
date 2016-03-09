def login_user
  login FactoryGirl.create(:user)
end

def login_instructor_user
  login FactoryGirl.create(:instructor_user)
end

def login_admin_user
  login FactoryGirl.create(:admin_user)
end

def login user
  @request.env["devise.mapping"] = Devise.mappings[:user]
  @user = user
  sign_in @user
end
