class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    "#{first_name} #{last_name}"
  end

  def owner?
    user_signed_in? && current_user.id == @instructor_profile.user_id
  end
end
