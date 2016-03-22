class NavbarConfig
  include Singleton

  PROPERTIES = [:user, :new_class_button, :back_link]

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
end
