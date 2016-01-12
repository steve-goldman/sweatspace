class AddUserIdToInstructorProfile < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :user_id, :integer
  end
end
