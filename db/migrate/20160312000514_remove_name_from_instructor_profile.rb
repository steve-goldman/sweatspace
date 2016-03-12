class RemoveNameFromInstructorProfile < ActiveRecord::Migration
  def change
    remove_column :instructor_profiles, :first_name
    remove_column :instructor_profiles, :last_name
  end
end
