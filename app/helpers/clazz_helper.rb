module ClazzHelper
  def class_summary_class clazz
    if clazz.timestamp < Time.now
      "past-class"
    else
      "future-class"
    end
  end
end
