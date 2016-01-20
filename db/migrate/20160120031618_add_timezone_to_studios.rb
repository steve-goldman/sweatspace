class AddTimezoneToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :timezone, :string
  end
end
