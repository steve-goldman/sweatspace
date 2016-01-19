class InstagramService
  include Singleton

  def self.init_client access_token
    @@access_token = access_token
  end

  def profile_picture_url uid
    user(uid).profile_picture
  end

  private

  def client
    @client ||= Instagram.client access_token: @@access_token
  end

  def user uid
    users[uid] ||= client.user uid
  end

  def users
    @users ||= {}
  end
end
