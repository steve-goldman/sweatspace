class InstructorProfileDecorator < Draper::Decorator
  delegate_all
  decorates_association :classes

  def full_name
    user.name
  end

  def any_social?
    [facebook, instagram, twitter, youtube].any? &:present?
  end

  def facebook_protocol
    "https://"
  end

  def facebook_stem
    "www.facebook.com/"
  end

  def facebook_link
    unless facebook.blank?
      "#{facebook_protocol}#{facebook_stem}#{facebook}"
    end
  end

  def instagram_protocol
    "https://"
  end

  def instagram_stem
    "www.instagram.com/"
  end

  def instagram_link
    unless instagram.blank?
      "#{instagram_protocol}#{instagram_stem}#{instagram}"
    end
  end

  def spotify_protocol
    "http://"
  end

  def spotify_stem
    "open.spotify.com/user/"
  end

  def spotify_link
    unless spotify.blank?
      "#{spotify_protocol}#{spotify_stem}#{spotify}"
    end
  end

  def twitter_protocol
    "https://"
  end

  def twitter_stem
    "twitter.com/"
  end

  def twitter_link
    unless twitter.blank?
      "#{twitter_protocol}#{twitter_stem}#{twitter}"
    end
  end

  def youtube_protocol
    "https://"
  end

  def youtube_stem
    "www.youtube.com/user/"
  end

  def youtube_link
    unless youtube.blank?
      "#{youtube_protocol}#{youtube_stem}#{youtube}"
    end
  end

  def display_created_at
    created_at.strftime "%Y-%m-%d"
  end
end
