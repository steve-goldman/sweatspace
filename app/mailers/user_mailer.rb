class UserMailer < ApplicationMailer
  def invited email, token
    @token = token
    mail to: email, subject: "You've been invited to join SweatSpace!"
  end
end
