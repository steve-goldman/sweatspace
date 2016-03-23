class NavbarConfig
  include Singleton

  PROPERTIES = [:user, :new_class_button, :back_link, :needs_landing_info, :needs_new_profile_info, :profile_page]

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

  def needs_landing_info?
    needs_landing_info
  end

  def needs_new_profile_info?
    needs_new_profile_info
  end

  def profile_page?
    profile_page
  end
end
