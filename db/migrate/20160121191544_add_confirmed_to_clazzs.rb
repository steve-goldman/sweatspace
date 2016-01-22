class AddConfirmedToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :confirmed, :boolean
    add_index :clazzs, :confirmed
  end
end
