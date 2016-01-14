class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    object.user.name
  end
end
