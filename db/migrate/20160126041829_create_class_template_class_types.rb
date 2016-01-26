class CreateClassTemplateClassTypes < ActiveRecord::Migration
  def change
    remove_index :class_templates, :clazz_type_id
    remove_column :class_templates, :clazz_type_id
    create_table :class_template_class_types do |t|
      t.integer :class_template_id
      t.integer :clazz_type_id

      t.timestamps null: false
    end
    add_index :class_template_class_types, :class_template_id
    add_index :class_template_class_types, :clazz_type_id
  end
end
