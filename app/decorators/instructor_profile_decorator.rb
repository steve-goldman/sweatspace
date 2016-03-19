class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    user.name
  end

  def any_social?
    [facebook, instagram, twitter, youtube].any? &:present?
  end

  def facebook_link
    unless facebook.blank?
      "https://www.facebook.com/#{facebook}"
    end
  end

  def instagram_link
    unless instagram.blank?
      "https://www.instagram.com/#{instagram}"
    end
  end

  def twitter_link
    unless twitter.blank?
      "https://twitter.com/#{twitter}"
    end
  end

  def youtube_link
    unless youtube.blank?
      "https://www.youtube.com/user/#{youtube}"
    end
  end
end
