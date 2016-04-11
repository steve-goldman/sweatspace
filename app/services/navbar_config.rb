class NavbarConfig
  include Singleton

  PROPERTIES = [
    :user,
    :new_class_button,
    :back_link,
    :needs_menu_dropdown,
    :wide_search,
    :profile_page
  ]

  PROPERTIES.each do |property|
    attr_accessor property
  end

  def clear
    PROPERTIES.each do |property|
      send "#{property}=", nil
    end
    self
  end

  def create_profile_button?
    user && user.instructor_profile.nil?
  end

  def new_class_button?
    new_class_button
  end

  def needs_menu_dropdown?
    needs_menu_dropdown
  end

  def wide_search?
    wide_search
  end

  def profile_page?
    profile_page
  end
end
