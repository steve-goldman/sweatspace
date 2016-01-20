class AddDeletedAtToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :deleted_at, :datetime
    add_index :clazzs, :deleted_at
  end
end
