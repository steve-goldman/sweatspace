class ChangeTimeToTimeOfDayInRepeatingClasses < ActiveRecord::Migration
  def change
    remove_column :repeating_classes, :time
    add_column :repeating_classes, :time_of_day, :string
  end
end
