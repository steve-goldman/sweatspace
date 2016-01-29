class AddCanceledToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :canceled, :boolean
    add_index :clazzs, :canceled
  end
end
