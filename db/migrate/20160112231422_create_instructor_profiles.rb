class CreateInstructorProfiles < ActiveRecord::Migration
  def change
    create_table :instructor_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :profile_path

      t.timestamps null: false
    end
    add_index :instructor_profiles, :profile_path
  end
end
