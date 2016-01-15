class AddClassTypeIdToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :clazz_type_id, :integer
  end
end
