class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    object.user.name
  end

  def profile_picture_url
    InstagramService.instance.profile_picture_url object.user.uid
  end

  def owner?
    user_signed_in? && current_user.id == @instructor_profile.user_id
  end
end
