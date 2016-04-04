class AddDurationToClassesAndRecurringClasses < ActiveRecord::Migration
  def change
    add_column :clazzs, :duration, :integer
    add_column :recurring_classes, :duration, :integer

    Clazz.all.each do |clazz|
      clazz.update_attributes duration: clazz.class_template.duration
    end

    RecurringClass.all.each do |recurring_class|
      recurring_class.update_attributes duration: recurring_class.class_template.duration
    end
  end
end
