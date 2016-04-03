class ClazzTypeDecorator < Draper::Decorator
  delegate_all
  decorates_association :class_template_class_types
end
