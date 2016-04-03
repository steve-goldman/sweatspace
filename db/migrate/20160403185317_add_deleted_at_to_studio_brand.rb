class AddDeletedAtToStudioBrand < ActiveRecord::Migration
  def change
    add_column :studio_brands, :deleted_at, :datetime
    add_index :studio_brands, :deleted_at
  end
end
