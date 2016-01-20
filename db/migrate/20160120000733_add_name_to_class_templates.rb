class AddNameToClassTemplates < ActiveRecord::Migration
  def change
    add_column :class_templates, :name, :string
  end
end
