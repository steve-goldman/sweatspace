class MapTemplatesToStudioBrand < ActiveRecord::Migration
  def change
    drop_table :class_template_studios

    remove_index :class_templates, :studio_id
    remove_column :class_templates, :studio_id
  end
end
