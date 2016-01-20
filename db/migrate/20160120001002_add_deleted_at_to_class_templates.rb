class AddDeletedAtToClassTemplates < ActiveRecord::Migration
  def change
    add_column :class_templates, :deleted_at, :datetime
    add_index :class_templates, :deleted_at
  end
end
