class RenameTimeToTimestampInClazzs < ActiveRecord::Migration
  def change
    rename_column :clazzs, :time, :timestamp
  end
end
