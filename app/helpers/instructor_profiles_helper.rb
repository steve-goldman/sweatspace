module InstructorProfilesHelper
  def profile_prev_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 min_date: date_range.prev_min_date,
                 max_date: date_range.prev_max_date
  end

  def profile_next_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 min_date: date_range.next_min_date,
                 max_date: date_range.next_max_date
  end
end
