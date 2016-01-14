class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :registerable
  validates :email, email: true, unless: :uid?
  has_one :instructor_profile
  acts_as_paranoid

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.nickname = auth.info.nickname
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end
end
