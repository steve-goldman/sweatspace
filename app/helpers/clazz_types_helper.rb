module ClazzTypesHelper
  def clazz_type_options
    ClazzType.all.map do |clazz_type|
      [clazz_type.name, clazz_type.id]
    end
  end
end
