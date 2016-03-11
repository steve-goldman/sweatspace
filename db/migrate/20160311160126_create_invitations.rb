class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :token
      t.string :invited_email
      t.datetime :accepted_at
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :invitations, :token
    add_index :invitations, :user_id
  end
end
