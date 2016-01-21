module ClazzHelper
  def class_template_options
    ClassTemplate.all.order(name: :asc).map do |class_template|
      [class_template.name, class_template.id]
    end
  end
end
