class Invitation < ActiveRecord::Base
  PERMITTED_PARAMS = [
    :invited_email
  ]

  belongs_to :user
  validates_presence_of :token, :invited_email
  validates :invited_email, email: true
  validates_presence_of :user_id, if: :accepted_at?

  scope :accepted, -> { where "accepted_at IS NOT NULL" }
  scope :not_accepted, -> { where "accepted_at IS NULL" }
end
