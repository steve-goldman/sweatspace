class NewsletterSignup < ActiveRecord::Base
  PERMITTED_PARAMS = [
    :email
  ]

  validates_presence_of :email
  validates :email, email: true
end
