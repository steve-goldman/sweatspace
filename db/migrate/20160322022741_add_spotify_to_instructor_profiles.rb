class AddSpotifyToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :spotify, :string
  end
end
