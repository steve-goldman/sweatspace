class Clazz < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "studio_id",
    "time",
    "duration",
  ]

  belongs_to :instructor_profile
  belongs_to :studio
  validates_presence_of :time
  validates_presence_of :duration
end
