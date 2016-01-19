class AddNameToClazz < ActiveRecord::Migration
  def change
    add_column :clazzs, :name, :string
  end
end
