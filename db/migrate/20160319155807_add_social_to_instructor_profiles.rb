class AddSocialToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :facebook, :string
    add_column :instructor_profiles, :instagram, :string
    add_column :instructor_profiles, :youtube, :string
    add_column :instructor_profiles, :twitter, :string
  end
end
