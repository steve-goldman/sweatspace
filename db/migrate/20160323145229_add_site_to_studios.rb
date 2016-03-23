class AddSiteToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :site, :string
  end
end
