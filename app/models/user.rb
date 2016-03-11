class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable, :recoverable
  validates :email, email: true
  has_one :instructor_profile
  acts_as_paranoid

  def today
    Time.now.in_time_zone(timezone).midnight
  end

  def timezone
    # TODO: detect automatically?
    @timezone ||= "Eastern Time (US & Canada)"
  end
end
