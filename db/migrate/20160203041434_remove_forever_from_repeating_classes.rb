class RemoveForeverFromRepeatingClasses < ActiveRecord::Migration
  def change
    remove_column :repeating_classes, :forever
  end
end
