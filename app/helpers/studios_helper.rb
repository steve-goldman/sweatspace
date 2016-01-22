module StudiosHelper
  def studio_options
    make_studio_options Studio.all
  end

  def not_class_template_studio_options class_template
    make_studio_options(Studio.all - class_template.studios)
  end

  def class_template_studio_options class_template
    make_studio_options class_template.studios
  end

  def make_studio_options studios
    studios.map do |studio|
      [studio.name, studio.id]
    end
  end
end
