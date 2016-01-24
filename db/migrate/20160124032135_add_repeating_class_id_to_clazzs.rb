class AddRepeatingClassIdToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :repeating_class_id, :integer
    add_index :clazzs, :repeating_class_id
  end
end
