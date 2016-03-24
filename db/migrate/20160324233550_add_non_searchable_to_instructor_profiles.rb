class AddNonSearchableToInstructorProfiles < ActiveRecord::Migration
  def change
    add_column :instructor_profiles, :non_searchable, :boolean
    add_index :instructor_profiles, :non_searchable
  end
end
