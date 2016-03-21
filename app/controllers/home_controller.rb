class HomeController < ApplicationController
  def random_profile
    offset = rand InstructorProfile.count
    random_profile = InstructorProfile.offset(offset).first
    redirect_to profile_path(random_profile.profile_path)
  end

  def faq
    @faq = Faq.instance
  end
end
