module ClazzTypesHelper
  def clazz_type_options
    make_clazz_type_options all_clazz_types
  end

  def not_class_template_class_type_options class_template
    make_clazz_type_options(all_clazz_types - class_template.clazz_types)
  end

  def class_template_class_type_options class_template
    make_clazz_type_options class_template.clazz_types
  end

  private

  def all_clazz_types
    ClazzType.all.order name: :asc
  end

  def make_clazz_type_options clazz_types
    clazz_types.map do |clazz_type|
      [clazz_type.name, clazz_type.id]
    end
  end
end
