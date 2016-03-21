module ApplicationHelper
  def modal_dialog
    content_tag :div, "",
                id: "modal-new-element",
                class: "modal fade",
                style: "display: none;",
                tabindex: "-1"
  end

  def flash_key key
    if key == "notice"
      "info"
    elsif key == "alert"
      "danger"
    else
      key
    end
  end

  def home_path
    if current_user.try(:instructor_profile).try(:persisted?)
      profile_path current_user.instructor_profile.profile_path
    else
      root_path
    end
  end

  def current_year
    Time.current.strftime "%Y"
  end

  def contact_address
    ContactService.instance.contact_address
  end
end
