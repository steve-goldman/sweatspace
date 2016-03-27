desc "recreate versions for instructor profile profile photos"
task recreate_versions_instructor_profile_profile_photos: :environment do
  InstructorProfile.find_each do |instructor_profile|
    if instructor_profile.profile_photo?
      instructor_profile.profile_photo.recreate_versions!
      instructor_profile.save!
    end
  end
end
