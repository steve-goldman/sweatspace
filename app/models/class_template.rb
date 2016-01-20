class ClassTemplate < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "clazz_type_id",
    "studio_id",
    "name",
    "description",
    "duration",
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :instructor_profile
  belongs_to :clazz_type
  belongs_to :studio
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :duration
end
