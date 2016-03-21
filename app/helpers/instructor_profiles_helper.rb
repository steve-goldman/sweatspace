module InstructorProfilesHelper
  def profile_prev_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 start_date: date_range.prev_start_date
  end

  def profile_next_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 start_date: date_range.next_start_date
  end

  def social_link site, instructor_profile, &block
    path = @instructor_profile.send("#{site}_link")
    options = {
      class: "btn btn-social-icon btn-#{site}",
      target: "_blank"
    }
    link_to path, options do
      block.call
    end
  end
end
