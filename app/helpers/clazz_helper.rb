module ClazzHelper
  def class_summary_class clazz
    if clazz.timestamp < Time.now
      "past-class"
    else
      "future-class"
    end
  end

  def class_canceled_class clazz
    if clazz.canceled?
      "canceled-class"
    else
      ""
    end
  end
end
