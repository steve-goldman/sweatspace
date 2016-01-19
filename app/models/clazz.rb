class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "clazz_type_id",
    "studio_id",
    "name",
    "time",
    "duration",
  ]

  belongs_to :instructor_profile
  belongs_to :clazz_type
  belongs_to :studio
  validates_presence_of :time
  validates_presence_of :duration
  validates_presence_of :name
end
