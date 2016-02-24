class AddSubstitutedToClazzs < ActiveRecord::Migration
  def change
    add_column :clazzs, :substituted, :boolean
  end
end
