class InvitationDecorator < Draper::Decorator
  delegate_all

  def display_accepted_at
    if accepted_at
      "Accepted on #{accepted_at.strftime("%Y-%m-%d")}"
    else
      "Not yet accepted"
    end
  end

  def display_user
    if accepted_at
      user.email
    else
      ""
    end
  end
end
