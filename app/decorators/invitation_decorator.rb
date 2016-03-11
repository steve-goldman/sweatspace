class InvitationDecorator < Draper::Decorator
  delegate_all

  def display_accepted_at
    if accepted_at
      "Accepted at #{accepted_at.strftime("%Y-%m-%d")}"
    else
      "Not yet accepted"
    end
  end

  def display_user
    if accepted_at
      "by #{user_id.email}"
    else
      ""
    end
  end
end
