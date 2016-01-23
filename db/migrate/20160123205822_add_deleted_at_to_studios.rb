class AddDeletedAtToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :deleted_at, :datetime
    add_index :studios, :deleted_at
  end
end
