class ChangeFirstDateToStringInRepeatingClasses < ActiveRecord::Migration
  def change
    remove_column :repeating_classes, :first_date
    add_column :repeating_classes, :first_date, :string
  end
end
