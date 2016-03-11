class InstructorProfile < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "first_name",
    "last_name",
    "profile_path",
    "user_id",
  ]

  validates_presence_of :profile_path, :first_name, :last_name
  validates_uniqueness_of :profile_path
  validates_format_of :profile_path, with: /\A([a-zA-Z]|\d)+(\-([a-zA-Z]|\d)+)*\z/
  belongs_to :user
  has_many :class_templates, through: :classes
  has_many :classes, class_name: "Clazz", dependent: :destroy
  has_many :recurring_classes, dependent: :destroy
  acts_as_paranoid
  has_paper_trail
end
