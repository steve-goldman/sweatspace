class InstructorProfile < ActiveRecord::Base
  include Elasticsearch::Model

  PERMITTED_PARAMS = [
    "profile_path",
    "user_id",
    "profile_photo",
    "remove_profile_photo",
    "cover_photo",
    "remove_cover_photo",
    "facebook",
    "instagram",
    "spotify",
    "youtube",
    "twitter",
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
            file_size: { less_than: 10.megabytes }
  mount_uploader :profile_photo, ProfilePhotoUploader
  validates :profile_photo,
            file_size: { less_than: 10.megabytes }
  scope :searchable, -> { where "non_searchable IS NULL OR non_searchable != 't'" }

  def as_indexed_json options = {}
    self.as_json(only: [:id, :profile_path, :facebook, :instagram, :youtube, :twitter, :spotify])
      .merge(name: user.name)
  end

  after_commit on: [:create] do
    __elasticsearch__.index_document unless non_searchable?
  end

  after_commit on: [:update] do
    if previous_changes[:non_searchable]
      if non_searchable?
        __elasticsearch__.delete_document
      else
        __elasticsearch__.index_document
      end
    else
      __elasticsearch__.update_document unless :non_searchable?
    end
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_document unless non_searchable?
  end
end
