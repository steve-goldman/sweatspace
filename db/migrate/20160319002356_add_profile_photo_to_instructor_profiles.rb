class AddProfilePhotoToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :profile_photo, :string
  end
end
