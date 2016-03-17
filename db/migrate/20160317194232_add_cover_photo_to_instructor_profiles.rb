class AddCoverPhotoToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :cover_photo, :string
  end
end
