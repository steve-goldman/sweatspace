class HomeController < ApplicationController
  layout "landing", only: :home

  def home
    if user_signed_in? && current_user.instructor_profile
      redirect_to profile_path(current_user.instructor_profile.profile_path)
    end
  end

  def random_profile
    redirect_to_random
  end

  def faq
    @faq = Faq.instance
  end

  private

  def redirect_to_random
    offset = rand InstructorProfile.searchable.count
    random_profile = InstructorProfile.searchable.offset(offset).first
    redirect_to profile_path(random_profile.profile_path)
  end
end
