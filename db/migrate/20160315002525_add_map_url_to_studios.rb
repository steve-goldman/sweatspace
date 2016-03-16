class AddMapUrlToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :map_url, :string
  end
end
