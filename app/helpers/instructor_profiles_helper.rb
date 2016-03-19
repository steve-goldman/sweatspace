module InstructorProfilesHelper
  def profile_prev_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 start_date: date_range.prev_start_date
  end

  def profile_next_page_path instructor_profile, date_range
    profile_path instructor_profile.profile_path,
                 start_date: date_range.next_start_date
  end

  def social_link site, instructor_profile, is_owner, &block
    path = @is_owner ? edit_social_ids_path : @instructor_profile.send("#{site}_link")
    options = { class: "btn btn-social-icon btn-#{site}" }
    if @is_owner
      options[:remote] = true
    else
      options[:target] = "_blank"
    end

    link_to path, options do
      block.call
    end
  end
end
