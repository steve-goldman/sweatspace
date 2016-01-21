class CreateClassTemplateStudios < ActiveRecord::Migration
  def change
    create_table :class_template_studios do |t|
      t.integer :class_template_id
      t.integer :studio_id

      t.timestamps null: false
    end
    add_index :class_template_studios, :class_template_id
    add_index :class_template_studios, :studio_id
  end
end
