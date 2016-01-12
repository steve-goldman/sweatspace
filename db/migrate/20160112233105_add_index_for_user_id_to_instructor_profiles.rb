class AddIndexForUserIdToInstructorProfiles < ActiveRecord::Migration
  def change
    add_index :instructor_profiles, :user_id
  end
end
