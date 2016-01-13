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
  validates_format_of :profile_path, with: /\A([a-zA-Z]|\d)+(\-([a-zA-Z]|\d)+)*\z/
  belongs_to :user
  has_many :classes, class_name: "Clazz"
  acts_as_paranoid
  has_paper_trail
end
