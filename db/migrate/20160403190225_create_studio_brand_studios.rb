class CreateStudioBrandStudios < ActiveRecord::Migration
  def change
    create_table :studio_brand_studios do |t|
      t.integer :studio_brand_id
      t.integer :studio_id
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :studio_brand_studios, :studio_brand_id
    add_index :studio_brand_studios, :studio_id
    add_index :studio_brand_studios, :deleted_at

    remove_index :studios, :studio_brand_id
    remove_column :studios, :studio_brand_id
  end
end
