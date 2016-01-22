class AddIndexOnTimestampForClazzs < ActiveRecord::Migration
  def change
    add_index :clazzs, :timestamp
  end
end
