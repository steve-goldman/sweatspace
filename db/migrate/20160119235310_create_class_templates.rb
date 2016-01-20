class CreateClassTemplates < ActiveRecord::Migration
  def change
    create_table :class_templates do |t|
      t.integer :instructor_profile_id
      t.integer :clazz_type_id
      t.integer :studio_id
      t.text :description
      t.integer :duration

      t.timestamps null: false
    end
    add_index :class_templates, :instructor_profile_id
    add_index :class_templates, :clazz_type_id
    add_index :class_templates, :studio_id
  end
end
