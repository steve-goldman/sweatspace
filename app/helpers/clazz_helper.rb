module ClazzHelper
  def class_template_options
    ClassTemplate.all.order(name: :asc).map do |class_template|
      [class_template.name, class_template.id]
    end
  end

  def class_summary_class clazz
    if clazz.timestamp < Time.now
      "past-class"
    else
      "future-class"
    end
  end
end
