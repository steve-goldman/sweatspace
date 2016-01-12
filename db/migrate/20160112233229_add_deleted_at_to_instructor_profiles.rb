class AddDeletedAtToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :deleted_at, :datetime
    add_index :instructor_profiles, :deleted_at
  end
end
