class ChangeDayOfWeekToIntegerInRepeatingClasses < ActiveRecord::Migration
  def change
    remove_column :repeating_classes, :day_of_week
    add_column :repeating_classes, :day_of_week, :integer
  end
end
