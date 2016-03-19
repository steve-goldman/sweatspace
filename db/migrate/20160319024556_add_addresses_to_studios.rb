class AddAddressesToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :address_1, :string
    add_column :studios, :address_2, :string
    add_column :studios, :address_3, :string
  end
end
