class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
