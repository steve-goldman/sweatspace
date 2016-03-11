class UserMailerPreview < ActionMailer::Preview
  def invited
    UserMailer.invited "example@email.com", UUIDTools::UUID.random_create.to_s
  end
end
