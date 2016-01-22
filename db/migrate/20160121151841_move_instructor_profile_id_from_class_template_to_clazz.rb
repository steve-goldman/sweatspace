class MoveInstructorProfileIdFromClassTemplateToClazz < ActiveRecord::Migration
  def change
    remove_index :class_templates, :instructor_profile_id
    remove_column :class_templates, :instructor_profile_id
    add_column :clazzs, :instructor_profile_id, :integer
    add_index :clazzs, :instructor_profile_id
  end
end
