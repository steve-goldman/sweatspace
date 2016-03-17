class InstructorProfile < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "profile_path",
    "user_id",
    "cover_photo",
    "remove_cover_photo"
  ]

  validates_presence_of :profile_path
  validates_uniqueness_of :profile_path
  validates_format_of :profile_path, with: /\A([a-zA-Z]|\d)+(\-([a-zA-Z]|\d)+)*\z/
  belongs_to :user
  has_many :class_templates, through: :classes
  has_many :classes, class_name: "Clazz", dependent: :destroy
  has_many :recurring_classes, dependent: :destroy
  acts_as_paranoid
  has_paper_trail
  mount_uploader :cover_photo, CoverPhotoUploader
  validates :cover_photo,
            file_size: { less_than: 5.megabytes }
end
