class InstructorProfile < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "profile_path",
    "user_id",
  ]

  validates_presence_of :profile_path
  validates_uniqueness_of :profile_path
  validates_format_of :profile_path, with: /\A([a-zA-Z]|\d)+(\-([a-zA-Z]|\d)+)*\z/
  belongs_to :user
  has_many :class_templates
  has_many :classes, through: :class_templates
  acts_as_paranoid
  has_paper_trail
end
