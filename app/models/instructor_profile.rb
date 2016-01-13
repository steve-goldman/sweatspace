class InstructorProfile < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "first_name",
    "last_name",
    "profile_path",
    "user_id",
  ]

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :profile_path
  validates_uniqueness_of :profile_path
  belongs_to :user
  acts_as_paranoid
  has_paper_trail
end
