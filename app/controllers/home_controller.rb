class HomeController < ApplicationController
  def dashboard
    @can_create_schedule = user_signed_in? && current_user.instructor_profile.nil?
  end

  def faq
  end
end
