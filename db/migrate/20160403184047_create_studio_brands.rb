class CreateStudioBrands < ActiveRecord::Migration
  def change
    create_table :studio_brands do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
    add_index :studio_brands, :name

    add_column :studios, :studio_brand_id, :integer
    add_index :studios, :studio_brand_id

    remove_column :studios, :url
  end
end
