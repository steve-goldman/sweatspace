class AddStudioBrandIdToClassTemplates < ActiveRecord::Migration
  def change
    add_column :class_templates, :studio_brand_id, :integer
    add_index :class_templates, :studio_brand_id
  end
end
