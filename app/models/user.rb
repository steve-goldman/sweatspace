class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable, :recoverable
  validates_presence_of :name
  validates :email, email: true
  has_one :instructor_profile, dependent: :destroy
  acts_as_paranoid

  def today
    Time.now.in_time_zone(timezone).midnight
  end

  def timezone
    # TODO: detect automatically?
    @timezone ||= "Eastern Time (US & Canada)"
  end
end
