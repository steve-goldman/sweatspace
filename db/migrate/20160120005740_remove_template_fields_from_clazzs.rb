class RemoveTemplateFieldsFromClazzs < ActiveRecord::Migration
  def change
    remove_index :clazzs, :instructor_profile_id
    remove_index :clazzs, :studio_id

    remove_column :clazzs, :instructor_profile_id
    remove_column :clazzs, :clazz_type_id
    remove_column :clazzs, :studio_id
    remove_column :clazzs, :name
    remove_column :clazzs, :duration

    add_column :clazzs, :class_template_id, :integer

    add_index :clazzs, :class_template_id
  end
end
