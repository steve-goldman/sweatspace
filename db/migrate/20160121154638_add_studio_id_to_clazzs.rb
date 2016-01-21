class AddStudioIdToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :studio_id, :integer
    add_index :clazzs, :studio_id
  end
end
