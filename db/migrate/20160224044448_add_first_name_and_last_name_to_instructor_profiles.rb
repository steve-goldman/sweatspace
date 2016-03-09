class AddFirstNameAndLastNameToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :first_name, :string
    add_column :instructor_profiles, :last_name, :string
  end
end
