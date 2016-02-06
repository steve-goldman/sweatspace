class RenameRepeatingClasses < ActiveRecord::Migration
  def change
    rename_table :repeating_classes, :recurring_classes
    rename_column :clazzs, :repeating_class_id, :recurring_class_id
  end
end
