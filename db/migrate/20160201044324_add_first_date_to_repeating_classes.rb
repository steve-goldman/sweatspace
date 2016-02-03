class AddFirstDateToRepeatingClasses < ActiveRecord::Migration
  def change
    add_column :repeating_classes, :first_date, :date
  end
end
